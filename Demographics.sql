--Query pulls demographic information for student applicants --


SELECT DISTINCT
S.STUDENT_NUMBER,
S.FIRST_NAME,
S.LAST_NAME,
S.GENDER,
S.STREET,
S.CITY,
s.schoolid,
case S.SCHOOLID
	when ### then 'A High School'
	when ### then 'B High School'
	when ### then 'C High School'
	when ### then 'D High School'
	when ### then 'E  High School'
	when ### then 'F High School'
	when ### then 'G High School'
	when ### then 'Graduated'
	when ### then 'H High School'
	when ### then 'I High School'
	when ### then 'J High School'
	when ### then 'K'
	end as Name_of_HS,
	S.DOB,
S.ETHNICITY,
case S_CA_STU_X.ELASTATUS 
	when 'EL' THEN 'Y'
	else 'N' END AS Is_EL,
case SCF.HOMELESS_CODE 
	WHEN 'Y' THEN 'Yes'
	ELSE 'No'
	END AS Homeless,
case S_CA_STU_X.PARENTED
	when '##' THEN 'Graduate Degree or Higher'
	when '##' THEN 'College Graduate'
	when '##' THEN 'Some College or AA Degree'
	when '##' THEN 'HS Grad'
	when '##' THEN 'Not a HS Grad'
	when '##' THEN 'Decline to State'
	else ' ' END AS ParentEd,
(select round((sum((sg.gpa_points + coalesce(sg.gpa_addedvalue,0))*(sg.potentialcrhrs)) / sum(sg.potentialcrhrs)),3)       
          from storedgrades sg
         where s.id=sg.studentid
           and sg.storecode IN ('S1','S2','S3','Q1','Q2','Q3','Q4')
           and sg.excludefromgpa = 0
           and sg.grade_level >= 9
           having sum(sg.potentialcrhrs) > 0
       ) CUM_HS_Weighted_GPA
FROM PS.STUDENTS S
JOIN SCHOOLS sch ON s.SCHOOLID = sch.SCHOOL_NUMBER 
LEFT JOIN S_CA_STU_X	ON s.DCID = S_CA_STU_X.STUDENTSDCID
LEFT JOIN PS.STUDENTCOREFIELDS SCF ON SCF.STUDENTSDCID = S.DCID
WHERE
S.STUDENT_NUMBER IN (
--LIST OF STUDENT NUMBERS HERE
)