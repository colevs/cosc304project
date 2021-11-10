import mysql.connector

class EnrollDB:
    """Application for an enrollment database on MySQL"""

    def connect(self):
        """Makes a connection to the database and returns connection to caller"""
        try:
            # TODO: Fill in your connection information
            print("Connecting to database.")
            self.cnx = mysql.connector.connect(user='cvanstei', password='83059345', host='cosc304.ok.ubc.ca', database='db_cvanstei')
            return self.cnx
        except mysql.connector.Error as err:  
            print(err)   

    def init(self):
        """Creates and initializes the database"""
        fileName = "university.ddl"
        print("Loading data")
        
        try:
            cursor = self.cnx.cursor()
            with open(fileName, "r") as infile:
                st = infile.read()
                commands = st.split(";")
                for line in commands:                   
                    # print(line.strip("\n"))
                    line = line.strip()
                    if line == "":  # Skip blank lines
                        continue 
                        
                    cursor.execute(line)                    
                        
            cursor.close()
            self.cnx.commit()            
            print("Database load complete")
        except mysql.connector.Error as err:  
            print(err)
            self.cnx.rollback()  
        
    def close(self):
        try:
            print("Closing database connection.")
            self.cnx.close()
        except mysql.connector.Error as err:  
            print(err)   

    def listAllStudents(self):
        """ Returns a String with all the students in the database.  
            Format:
                sid, sname, sex, birthdate, gpa
                00005465, Joe Smith, M, 1997-05-01, 3.20

            Return:
                String containing all student information"""

        print("Executing list all students.")
        
        output = "sid, sname, sex, birthdate, gpa"
        cursor = self.cnx.cursor()
        # TODO: Execute query and build output string
        query = "SELECT * FROM student"
        cursor.execute(query)
        for (sid, sname, sex, birthdate, gpa) in cursor:
            output += f'\n{sid}, {sname}, {sex}, {birthdate}, {gpa}'       
        cursor.close()
        
        return output

    def listDeptProfessors(self, deptName):
        """Returns a String with all the professors in a given department name.
           Format:
                    Professor Name, Department Name
                    Art Funk, Computer Science
           Returns:
                    String containing professor information"""

        # TODO: Execute query and build output string
        output = "Professor Name, Department Name"
        cursor = self.cnx.cursor()
        query = "SELECT * FROM prof WHERE dname = %s"
        cursor.execute(query, (deptName,))
        for (pname, dname) in cursor:
            output += f'\n{pname}, {dname}'
        cursor.close()

        return output

    def listCourseStudents(self, courseNum):
        """Returns a String with all students in a given course number (all sections).
            Format:
                Student Id, Student Name, Course Number, Section Number
                00005465, Joe Smith, COSC 304, 001
            Return:
                 String containing students"""

        # TODO: Execute query and build output string
        output = "Student Id, Student Name, Course Number, Section Number"
        cursor = self.cnx.cursor()
        query = "SELECT student.sid, sname, cnum, secnum FROM student JOIN enroll ON student.sid=enroll.sid WHERE enroll.cnum = %s"
        cursor.execute(query, (courseNum,))
        for (sid, sname, cnum, secnum) in cursor:
            output += f'\n{sid}, {sname}, {cnum}, {secnum}'
        cursor.close()

        return output

    def computeGPA(self, studentId):
        """Returns a cursor with a row containing the computed GPA (named as gpa) for a given student id."""

        # TODO: Execute the query and return a cursor
        cursor = self.cnx.cursor()
        query = ("SELECT AVG(grade) AS gpa "
                "FROM enroll "
                "WHERE sid = %s")
        cursor.execute(query, (studentId,))
        return cursor

    def addStudent(self, studentId, studentName, sex, birthDate):
        """Inserts a student into the databases."""

        # TODO: Execute statement. Make sure to commit
        cursor = self.cnx.cursor()
        sql = "INSERT INTO student(sid, sname, sex, birthDate) VALUES (%s, %s, %s, %s)"
        cursor.execute(sql, (studentId, studentName, sex, birthDate))
        cursor.close()
        self.cnx.commit()
        
        return  
    
    def deleteStudent(self, studentId):
        """Deletes a student from the databases."""

        # TODO: Execute statement. Make sure to commit
        cursor = self.cnx.cursor()
        sql = "DELETE FROM student WHERE sid = %s"
        cursor.execute(sql, (studentId,))
        cursor.close()
        self.cnx.commit()

        return

    def updateStudent(self, studentId, studentName, sex, birthDate, gpa):
        """Updates a student in the databases."""

        # TODO: Execute statement. Make sure to commit
        cursor = self.cnx.cursor()
        sql = ("UPDATE student SET sname = %s, sex = %s, birthdate = %s, gpa = %s "
                "WHERE sid = %s")
        cursor.execute(sql, (studentName, sex, birthDate, gpa, studentId))
        cursor.close()
        self.cnx.commit()

        return
        
    def newEnroll(self, studentId, courseNum, sectionNum, grade):
        """Creates a new enrollment in a course section."""
        
        # TODO: Execute statement. Make sure to commit
        cursor = self.cnx.cursor()
        sql = "INSERT INTO enroll(sid, cnum, secnum, grade) VALUES (%s, %s, %s, %s)"
        cursor.execute(sql, (studentId, courseNum, sectionNum, grade))
        cursor.close()
        self.cnx.commit()

        return

    def updateStudentGPA(self, studentId):
        """ Updates a student's GPA based on courses taken."""

        # TODO: Execute statement. Make sure to commit
        cursor = self.cnx.cursor()
        sql = ("UPDATE student SET gpa = ("
                    "SELECT AVG(grade) "
                    "FROM enroll "
                    "WHERE sid = %s "
                    "GROUP BY sid) "
                "WHERE student.sid = %s")
        cursor.execute(sql, (studentId,studentId))
        cursor.close()
        self.cnx.commit()

        return

    def removeStudentFromSection(self, studentId, courseNum, sectionNum):
        """Removes a student from a course and updates their GPA."""

        # TODO: Execute statement. Make sure to commit
        cursor = self.cnx.cursor()
        sql = "DELETE FROM enroll WHERE sid = %s AND cnum = %s AND secnum = %s"
        cursor.execute(sql, (studentId, courseNum, sectionNum))
        cursor.close()
        self.cnx.commit()

        self.updateStudentGPA(studentId)

        return

    def updateStudentMark(self, studentId, courseNum, sectionNum, grade):
        """Updates a student's mark in an enrolled course section and updates their grade."""

        # TODO: Execute statement. Make sure to commit
        cursor = self.cnx.cursor()
        sql = "UPDATE enroll SET grade = %s WHERE sid = %s AND cnum = %s AND secnum = %s"
        cursor.execute(sql, (grade, studentId, courseNum, sectionNum))
        cursor.close()
        self.cnx.commit()

        self.updateStudentGPA(studentId)

        return

    def query1(self):
        """Return the list of students (id and name) that have not registered in any course section. Hint: Left join can be used instead of a subquery."""

        # TODO: Execute the query and return a cursor
        cursor = self.cnx.cursor()
        query = ("SELECT student.sid, student.sname "
                "FROM student LEFT JOIN enroll ON student.sid = enroll.sid "
                "WHERE enroll.sid is NULL")
        cursor.execute(query)

        return cursor

    def query2(self):
        """For each student return their id and name, number of course sections registered in (called numcourses), and gpa (average of grades). 
        Return only students born after March 15, 1992. A student is also only in the result if their gpa is above 3.1 or registered in 0 courses.
        Order by GPA descending then student name ascending and show only the top 5."""

        # TODO: Execute the query and return a cursor
        cursor = self.cnx.cursor()
        query = ("SELECT student.sid, sname, COUNT(secnum) AS numcourses, AVG(grade) AS gpa "
                "FROM student LEFT JOIN enroll ON student.sid = enroll.sid "
                "WHERE birthdate > '1992-03-15' "
                "GROUP BY sid, sname "
                "HAVING gpa > 3.1 OR numcourses = 0 "
                "ORDER BY gpa DESC "
                "LIMIT 5")
        cursor.execute(query)

        return cursor

    def query3(self):
        """For each course, return the number of sections (numsections), total number of students enrolled (numstudents), average grade (avggrade), and number of distinct professors who taught the course (numprofs).
            Only show courses in Chemistry or Computer Science department. Make sure to show courses even if they have no students. Do not show a course if there are no professors teaching that course. 
            Format:
            cnum, numsections, numstudents, avggrade, numprof"""

        # TODO: Execute the query and return a cursor
        cursor = self.cnx.cursor()
        query = ("SELECT course.cnum, COUNT(DISTINCT section.secnum) as numsections, COUNT(sid) as numstudents, AVG(grade) as avggrade, COUNT(DISTINCT pname) as numprofs "
                "FROM section JOIN course ON section.cnum = course.cnum LEFT JOIN enroll ON section.cnum = enroll.cnum AND section.secnum = enroll.secnum "
                "WHERE course.dname = 'Chemistry' OR course.dname = 'Computer Science' "
                "GROUP BY course.cnum "
                "HAVING numprofs > 0")
        cursor.execute(query)

        return cursor

    def query4(self):
        """Return the students who received a higher grade than their course section average in at least two courses. Order by number of courses higher than the average and only show top 5.
            Format:
            EmployeeId, EmployeeName, orderCount"""

        # TODO: Execute the query and return a cursor
        cursor = self.cnx.cursor()
        query = ("SELECT student.sid, student.sname, numhigher "
                "FROM student NATURAL JOIN ("
                    "SELECT sid, COUNT(sid) AS numhigher "
                    "FROM enroll NATURAL JOIN ("
                        "SELECT cnum, secnum, AVG(grade) as avgGrade "
                        "FROM enroll AS B "
                        "GROUP BY cnum, secnum"
                    ") AS C "
                    "WHERE enroll.grade > C.avgGrade "
                    "GROUP BY sid "
                    "HAVING numhigher >= 2) AS G "
                "ORDER BY numhigher DESC, sname ASC "
                "LIMIT 5")
        cursor.execute(query)

        return cursor


# Do NOT change anything below here
    def resultSetToString(self, cursor, maxrows):
        output = ""
        cols = cursor.column_names
        output += "Total columns: "+str(len(cols))+"\n"
        output += str(cols[0])
        for i in range(1,len(cols)):
            output += ", "+str(cols[i])
        for row in cursor:
            output += "\n"+str(row[0])
            for i in range(1,len(cols)):
                output += ", "+str(row[i])
        output += "\nTotal results: "+str(cursor.rowcount)
        return output

if __name__ == '__main__':
    # Main execution for testing
    enrollDB = EnrollDB()
    enrollDB.connect()
    # enrollDB.init()

    # print(enrollDB.listAllStudents())

    # print("Executing list professors in a department: Computer Science")
    # print(enrollDB.listDeptProfessors("Computer Science"))
    # print("Executing list professors in a department: none")
    # print(enrollDB.listDeptProfessors("none"))

    # print("Executing list students in course: COSC 304")
    # print(enrollDB.listCourseStudents("COSC 304"))
    # print("Executing list students in course: DATA 301")
    # enrollDB.listCourseStudents("DATA 301")

    # print("Executing compute GPA for student: 45671234")
    # print(enrollDB.resultSetToString(enrollDB.computeGPA("45671234"),10))
    # print("Executing compute GPA for student: 00000000")
    # print(enrollDB.resultSetToString(enrollDB.computeGPA("00000000"),10))

    # print("Adding student 55555555:")
    # enrollDB.addStudent("55555555",  "Stacy Smith", "F", "1998-01-01")
    # print("Adding student 11223344:")
    # enrollDB.addStudent("11223344",  "Jim Jones", "M",  "1997-12-31")
    # print(enrollDB.listAllStudents())

    # print("Test delete student:");
    # print("Deleting student 99999999:")
    # enrollDB.deleteStudent("99999999")
    # # Non-existing student
    # print("Deleting student 00000000:")
    # enrollDB.deleteStudent("00000000")
    # print(enrollDB.listAllStudents())

    # print("Updating student 99999999:")
    # enrollDB.updateStudent("99999999",  "Wang Wong", "F", "1995-11-08", 3.23)
    # print("Updating student 00567454:")
    # enrollDB.updateStudent("00567454",  "Scott Brown", "M",  None, 4.00)
    # print(enrollDB.listAllStudents())

    # print("Test new enrollment in COSC 304 for 98123434:")
    # enrollDB.newEnroll("98123434", "COSC 304", "001", 2.51)

    # enrollDB.init()
    # print("Test update student GPA for student:")
    # enrollDB.newEnroll("98123434", "COSC 304", "001", 3.97);  
    # enrollDB.updateStudentGPA("98123434")

    # print("Test update student mark for student 98123434 to 3.55:")
    # enrollDB.updateStudentMark("98123434", "COSC 304", "001", 3.55)

    # enrollDB.init()

    # enrollDB.removeStudentFromSection("00546343", "CHEM 113", "002")

    # Queries
    # Re-initialize all data
    enrollDB.init()
    print(enrollDB.resultSetToString(enrollDB.query1(), 100))
    print()
    print(enrollDB.resultSetToString(enrollDB.query2(), 100))
    print()
    print(enrollDB.resultSetToString(enrollDB.query3(), 100))
    print()
    print(enrollDB.resultSetToString(enrollDB.query4(), 100))
            
    enrollDB.close()
