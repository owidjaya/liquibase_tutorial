--liquibase formatted file

--changeset oscarw:1 context:mssql runOnChange:true
--preconditions onFail:CONTINUE onError:HALT
--precondtion-sql-check expectedResult:0 IF EXISTS( SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA ='dbo' AND TABLE_NAME='School') SELECT 1 else SELECT 0
CREATE TABLE dbo.School (
    schoolId int  NOT NULL IDENTITY(1,1),
    name varchar(255) NOT NULL,
    CONSTRAINT school_pk
        PRIMARY KEY(SchoolId)
)
--rollback drop table dbo.School

--changeset oscarw:2 context:mssql
CREATE TABLE dbo.EmployeeSchool (
    employeeId int,
    schoolId int,
    CONSTRAINT employeeSchool_pk PRIMARY KEY(employeeId, schoolId),
    CONSTRAINT employeeSchool_school_fk FOREIGN KEY(schoolId) REFERENCES dbo.School(schoolId) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT employeeSchool_employee_fk FOREIGN KEY(employeeId) REFERENCES dbo.Employee(id) ON DELETE CASCADE ON UPDATE CASCADE
)
--rollback drop table dbo.EmployeeSchool