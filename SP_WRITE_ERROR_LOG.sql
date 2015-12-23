CREATE OR REPLACE 
PROCEDURE SP_WRITE_ERROR_LOG 
IS L_INFORM_ID NUMBER;
L_ERROR_CODE VARCHAR2(20);
L_ERROR_MSG VARCHAR2(200);
   CURSOR C_INFORM_ID
   IS
     SELECT INFORM_ID
     FROM INFORM
     WHERE RECEIVED_DATE > (CURRENT_DATE - 1);
/*
TBK001	Require				กรุณากรอกข้อมูล {column}
TBK002	Valid					ข้อมูล {column} ไม่ตรงกับข้อมูลในฐาน กรุณาตรวจสอบอีกครั้ง
TBK003	Format				ข้อมูล {column} ไม่ตรงกับรูปแบบเลขที่บัตรประชาชน 13 หลัก
TBK004	Format				ข้อมูลปีรถ ต้องเป็นปี คศ กรุณาตรวจสอบอีกครั้ง
TBK005	Duplicate			ข้อมูลทะเบียนรถนี้ มีในระบบแล้ว
TBK006	Format				ข้อมูล {column}  ไม่ถูกต้อง
TBK007	Out of range	ระยะเวลาในการคุ้มครองประกันภัย จะต้องมากกว่า 6 เดือน
*/
BEGIN

--incomplete
   OPEN C_INFORM_ID;
   FETCH C_INFORM_ID INTO L_INFORM_ID;
	 
   IF L_ERROR_CODE IS NOT NULL THEN
		INSERT INTO ERROR_LOG(ERROR_LOG_ID,ERROR_CODE,INFORM_ID,CREATE_DATE,ERROR_MSG)
		SELECT SEQ_ERROR_LOG.NEXTVAL,L_ERROR_CODE,L_INFORM_ID,CURRENT_DATE,L_ERROR_MSG
		FROM DUAL;
	 END IF;

   CLOSE C_INFORM_ID;




END;

