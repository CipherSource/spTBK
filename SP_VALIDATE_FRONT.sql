CREATE OR REPLACE 
PROCEDURE SP_VALIDATE_FRONT AS
L_FRONT_ID NUMBER;
L_INFORM_ID NUMBER;
L_ERROR_CODE VARCHAR2(20);
L_ERROR_MSG VARCHAR2(200);
L_INFORM_ID_CURRVAL NUMBER;
   CURSOR C_TBK001_CUST_ID
   IS
     SELECT FRONT_ID
     FROM FRONT
		 WHERE CUST_ID IS NULL;
TYPE T_INFORM IS TABLE OF INFORM.INFORM_ID%TYPE
      INDEX BY BINARY_INTEGER;
L_INFORM T_INFORM;
/*
TBK001	Require				กรุณากรอกข้อมูล {column}
TBK002	Valid					ข้อมูล {column} ไม่ตรงกับข้อมูลในฐาน กรุณาตรวจสอบอีกครั้ง
TBK003	Format				ข้อมูล {column} ไม่ตรงกับรูปแบบเลขที่บัตรประชาชน 13 หลัก
TBK004	Format				ข้อมูลปีรถ ต้องเป็นปี คศ กรุณาตรวจสอบอีกครั้ง
TBK005	Duplicate			ข้อมูลทะเบียนรถนี้ มีในระบบแล้ว
TBK006	Format				ข้อมูล {column}  ไม่ถูกต้อง
TBK007	Out of range	ระยะเวลาในการคุ้มครองประกันภัย จะต้องมากกว่า 6 เดือน

TBK001 Required Fields: 
CUST_ID	ไม่ได้ใส่รหัสลูกค้า
CONTRACT_CODE	ไม่ได้ใส่รหัสสถานะ
APPROVE_DATE	ไม่มีวันที่รับแจ้ง
MKT_NAME	ไม่มีชื่อผู้แจ้ง
MKT_NUMBER	ไม่ได้ใส่รหัสผู้แจ้ง
MKT_TEAM_CODE 	ไม่มีค่าทีม
CUST_NAME	ไม่มีชื่อลูกค้า
ID_CARD	ไม่มีเลขที่บัตรประชาชน
CAR_BRAND	ไม่มีชื่ยี่ห้อ
CAR_MODEL	ไม่มีรุ่นรถ
PLAT_PROVINCE	ไม่มีจังหวัดทะเบียนรถปกติ
ENGINE_NO	ไม่มีเลขเครื่อง
SN_BODY	ไม่มีเลขตัวถัง
EXPIRE_DATE	ไม่มีวันหมดอายุภาษีทะเบียน ?? ask for confirmation
INS_CODE	ไม่ได้ใส่รหัสบริษัทที่ต่อประกัน
SUM_INS_AMT	ไม่มีทุนประกัน
PREMIUM_AMT	ไม่มีค่าเบี้ยรวม
WHT_AMT	ไม่มีจำนวนเงินWHT
REF_CODE	ไม่มีค่ารหัสประเภทรถ
REF_NAME	ไม่มีประเภทรถ
REPAIR_PLACE	ไม่มีสถานที่ซ่อม
ASSESS_AMT	ไม่มีค่าความเสียหายส่วนแรก
DISCOUNT_GROUP_PERCENT	ไม่มีค่าส่วนลดกลุ่ม_บาท%
NCB_PERCENT	ไม่มีค่าส่วนลดประวัติดี
NCB_AMOUNT	ไม่มีค่าส่วนลดประวัติดี_บาท
DISCOUNT_AMT	ไม่มีค่าส่วนลด
RECEIVE_ADDR	ไม่มีที่อยู่ออกใบเสร็จ
POST_ADDR_1	ไม่มีที่อยู่ส่งเอกสารของลูกค้า1
POST_ADDR_2	ไม่มีที่อยู่ส่งเอกสารของลูกค้า2
POST_CODE	ไม่มีรหัสไปรษณีย์
*/
BEGIN

--Get initial INFORM_ID
SELECT LAST_NUMBER INTO L_INFORM_ID_CURRVAL
FROM ALL_SEQUENCES
WHERE  SEQUENCE_NAME = 'SEQ_INFORM';


--Insert data from FRONT to INFORM
INSERT INTO INFORM(
INFORM_ID,
INFORM_NO,
RECEIVED_DATE,
--SENT_DATE,
--CODE_CMI,
--CODE_STICKER,
CUST_ID,
CA_NO,
CONTRACT_CODE,
CONTRACT_STATUS,
APPROVE_DATE,
MKT_NAME,
MKT_NUMBER,
MKT_TEAM_CODE,
CUST_NAME,
ID_CARD,
ISSUE_ID_DATE,
EXPIRE_ID_DATE,
CAR_BRAND_CODE,
CAR_BRAND,
CAR_MODEL,
CAR_YEAR,
PLAT_NO,
PROVINCE_ID,
PLAT_PROVINCE,
ENGINE_CC,
ENGINE_NO,
SN_BODY,
TAX_EXP_DATE,
DEALER_CODE,
INS_CODE,
INS_NAME,
INS_TYPE_CODE,
INS_TYPE,
INS_LEVEL_ID,
INS_LEVEL_DESC,
SUM_INS_AMT,
PREMIUM_AMT,
WHT_AMT,
INS_DUTY,
--INFORM_NO_INS,
PAY_INSTALLMENT,
PAY1_DATE,
PAY2_DATE,
PAY3_DATE,
PAYMENT_TYPE,
PATTERN_RATE,
REF_CODE,
REF_NAME,
REPAIR_PLACE_CODE,
REPAIR_PLACE,
DRIVER1_NAME,
DRIVER1_LICENSE_NO,
DRIVER1_ID_CARD,
DRIVER1_BIRTHDATE,
DRIVER2_NAME,
DRIVER2_LICENSE_NO,
DRIVER2_ID_CARD,
DRIVER2_BIRTHDATE,
COVER_DATE,
EXPIRE_DATE,
ASSESS_AMT,
DISCOUNT_GROUP_PERCENT,
NCB_PERCENT,
NCB_AMOUNT,
DISCOUNT_AMT,
REMARK,
POLICY_NO,
PREV_INS_CODE,
PREV_INS_NAME,
RECEIVE_ADDR,
POST_ADDR_1,
POST_ADDR_2,
POST_CODE,
--CAR_USAGE,
--BRANCH_ID,
INS_VAT,
CHANG_ACT_ADDR,
CHANG_ACT_BILL,
CHANG_DEPARTMENT_ADDR
)
SELECT SEQ_INFORM.NEXTVAL,
'TBK'||INS_CODE||'-'||'255812' || LPAD(INS_CODE_NO, 4, '0') INFORM_NO,
CURRENT_DATE,
--SENT_DATE,
--CODE_CMI,
--CODE_STICKER,
CUST_ID,
CA_NO,
CONTRACT_CODE,
CONTRACT_STATUS,
APPROVE_DATE,
MKT_NAME,
MKT_NUMBER,
MKT_TEAM_CODE,
CUST_NAME,
ID_CARD,
ISSUE_ID_DATE,
EXPIRE_ID_DATE,
CAR_BRAND_CODE,
CAR_BRAND,
CAR_MODEL,
CAR_YEAR,
PLAT_NO,
PROVINCE_ID,
PLAT_PROVINCE,
ENGINE_CC,
ENGINE_NO,
SN_BODY,
TAX_EXP_DATE,
DEALER_CODE,
INS_CODE,
INS_NAME,
INS_TYPE_CODE,
INS_TYPE,
INS_LEVEL_ID,
INS_LEVEL_DESC,
SUM_INS_AMT,
PREMIUM_AMT,
WHT_AMT,
INS_DUTY,
--INFORM_NO_INS,
PAY_INSTALLMENT,
PAY1_DATE,
PAY2_DATE,
PAY3_DATE,
PAYMENT_TYPE,
PATTERN_RATE,
REF_CODE,
REF_NAME,
REPAIR_PLACE_CODE,
REPAIR_PLACE,
DRIVER1_NAME,
DRIVER1_LICENSE_NO,
DRIVER1_ID_CARD,
DRIVER1_BIRTHDATE,
DRIVER2_NAME,
DRIVER2_LICENSE_NO,
DRIVER2_ID_CARD,
DRIVER2_BIRTHDATE,
COVER_DATE,
EXPIRE_DATE,
ASSESS_AMT,
DISCOUNT_GROUP_PERCENT,
NCB_PERCENT,
NCB_AMOUNT,
DISCOUNT_AMT,
REMARK,
POLICY_NO,
PREV_INS_CODE,
PREV_INS_NAME,
RECEIVE_ADDR,
POST_ADDR_1,
POST_ADDR_2,
POST_CODE,
--CAR_USAGE,
--BRANCH_ID,
INS_VAT,
CHANG_ACT_ADDR,
CHANG_ACT_BILL,
CHANG_DEPARTMENT_ADDR 
FROM (
SELECT 
ROW_NUMBER () OVER (PARTITION BY INS_CODE ORDER BY FRONT_ID) INS_CODE_NO,
FRONT_ID,
CURRENT_DATE,
--SENT_DATE,
--CODE_CMI,
--CODE_STICKER,
CUST_ID,
CA_NO,
CONTRACT_CODE,
CONTRACT_STATUS,
APPROVE_DATE,
MKT_NAME,
MKT_NUMBER,
MKT_TEAM_CODE,
CUST_NAME,
ID_CARD,
ISSUE_ID_DATE,
EXPIRE_ID_DATE,
CAR_BRAND_CODE,
CAR_BRAND,
CAR_MODEL,
CAR_YEAR,
PLAT_NO,
PROVINCE_ID,
PLAT_PROVINCE,
ENGINE_CC,
ENGINE_NO,
SN_BODY,
TAX_EXP_DATE,
DEALER_CODE,
INS_CODE,
INS_NAME,
INS_TYPE_CODE,
INS_TYPE,
INS_LEVEL_ID,
INS_LEVEL_DESC,
SUM_INS_AMT,
PREMIUM_AMT,
WHT_AMT,
INS_DUTY,
--INFORM_NO_INS,
PAY_INSTALLMENT,
PAY1_DATE,
PAY2_DATE,
PAY3_DATE,
PAYMENT_TYPE,
PATTERN_RATE,
REF_CODE,
REF_NAME,
REPAIR_PLACE_CODE,
REPAIR_PLACE,
DRIVER1_NAME,
DRIVER1_LICENSE_NO,
DRIVER1_ID_CARD,
DRIVER1_BIRTHDATE,
DRIVER2_NAME,
DRIVER2_LICENSE_NO,
DRIVER2_ID_CARD,
DRIVER2_BIRTHDATE,
COVER_DATE,
EXPIRE_DATE,
ASSESS_AMT,
DISCOUNT_GROUP_PERCENT,
NCB_PERCENT,
NCB_AMOUNT,
DISCOUNT_AMT,
REMARK,
POLICY_NO,
PREV_INS_CODE,
PREV_INS_NAME,
RECEIVE_ADDR,
POST_ADDR_1,
POST_ADDR_2,
POST_CODE,
--CAR_USAGE,
--BRANCH_ID,
INS_VAT,
CHANG_ACT_ADDR,
CHANG_ACT_BILL,
CHANG_DEPARTMENT_ADDR 
FROM FRONT 
ORDER BY FRONT_ID) tmp;
--RETURNING INFORM_ID INTO L_INFORM_ID; --oracle 11g INSERT...SELECT...RETURNING doesn't work

--STAMP INFORM_ID back to TABLE FRONT
MERGE INTO FRONT F
USING (
SELECT FRONT_ID FID, ROW_NUMBER () OVER (ORDER BY FRONT_ID) ROWNO 
FROM FRONT
)
ON (F.FRONT_ID = FID )
WHEN MATCHED THEN
UPDATE 
SET F.INFORM_ID = ROWNO + L_INFORM_ID_CURRVAL - 1;


--CHECK TBK001
/*
   OPEN C_TBK001_CUST_ID;
   FETCH C_TBK001_CUST_ID INTO L_FRONT_ID;

		INSERT INTO ERROR_LOG(ERROR_LOG_ID,ERROR_CODE,INFORM_ID,CREATE_DATE,ERROR_MSG)
		SELECT SEQ_ERROR_LOG.NEXTVAL,L_ERROR_CODE,L_INFORM_ID,CURRENT_DATE,'ไม่ได้กรอก รหัสลูกค้า'
		FROM DUAL;

   CLOSE C_TBK001_CUST_ID;
*/
END;
