CREATE OR REPLACE 
PROCEDURE SP_VALIDATE_FRONT AS

L_INFORM_ID_CURRVAL NUMBER;
L_YEAR CHAR(4);
L_MONTH CHAR(2);
L_ERROR_FLAG NUMBER;
P_IN_STATUS_TYPE VARCHAR2(20);
P_IN_STATUS VARCHAR2(5);
P_IN_INFORM_ID NUMBER;
P_IN_STOCK_ID NUMBER;
P_IN_TARO_ID NUMBER;
P_IN_EMP_ID VARCHAR2(50);
P_OUT_RESULT NUMBER;
BEGIN

--Get initial INFORM_ID
SELECT LAST_NUMBER INTO L_INFORM_ID_CURRVAL
FROM ALL_SEQUENCES
WHERE  SEQUENCE_NAME = 'SEQ_INFORM';

--Insert data from FRONT to INFORM
INSERT INTO INFORM(
INFORM_ID,
--INFORM_NO,
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
--'TBK'||INS_CODE||'-'||L_YEAR||L_MONTH|| LPAD(INS_CODE_NO, 4, '0') INFORM_NO,
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
--ROW_NUMBER () OVER (PARTITION BY INS_CODE ORDER BY FRONT_ID) INS_CODE_NO,
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
WHERE INFORM_ID IS NULL
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

--Stamp Status = 'FR' after inserting from FRONT to INFORM
FOR FRONT_REC IN (
    SELECT INFORM_ID
    FROM FRONT
    ORDER BY FRONT_ID)
LOOP
BEGIN
    P_IN_STATUS_TYPE := 'TXN' ;
    P_IN_STATUS := 'FR';
    P_IN_INFORM_ID := FRONT_REC.INFORM_ID;
    P_IN_STOCK_ID := NULL ;
    P_IN_TARO_ID := NULL;
    P_IN_EMP_ID := '0' ;

SP_WRITE_STATUS(P_IN_STATUS_TYPE,P_IN_STATUS,P_IN_INFORM_ID,P_IN_STOCK_ID,P_IN_TARO_ID,P_IN_EMP_ID,P_OUT_RESULT);
END;
END LOOP;

--Stamp Status = 'VP' if no errors were found
--Stamp Status = 'VF' if an error is found
FOR FRONT_REC IN (
    SELECT INFORM_ID
    FROM INFORM
    WHERE INFORM_ID IN (SELECT INFORM_ID FROM STATUS WHERE TXN_STATUS = 'FR')
    ORDER BY INFORM_ID)
LOOP
BEGIN

SP_WRITE_ERROR_LOG(FRONT_REC.INFORM_ID, L_ERROR_FLAG);

    P_IN_STATUS_TYPE := 'TXN' ;
    IF L_ERROR_FLAG = 0 THEN
    P_IN_STATUS := 'VP';
    ELSIF L_ERROR_FLAG = 1 THEN
    P_IN_STATUS := 'VF';
    END IF;
    P_IN_INFORM_ID := FRONT_REC.INFORM_ID;
    P_IN_STOCK_ID := NULL ;
    P_IN_TARO_ID := NULL;
    P_IN_EMP_ID := '0' ;

SP_WRITE_STATUS(P_IN_STATUS_TYPE,P_IN_STATUS,P_IN_INFORM_ID,P_IN_STOCK_ID,P_IN_TARO_ID,P_IN_EMP_ID,P_OUT_RESULT);
END;
END LOOP;


--Get Buddhist Year and Month
SELECT EXTRACT(YEAR FROM CURRENT_DATE)+543 INTO L_YEAR FROM DUAL;
SELECT EXTRACT(MONTH FROM CURRENT_DATE) INTO L_MONTH FROM DUAL;
--UPDATE INFORM_NO based on INFORM_ID in FRONT
UPDATE INFORM
SET INFORM_NO = (SELECT 'TBK'||INS_CODE||'-'||SUBSTR(L_YEAR,-2)||L_MONTH|| LPAD(INS_CODE_NO, 5, '0')
                                FROM(
                                SELECT
                                I.INFORM_ID,
                                ROW_NUMBER () OVER (PARTITION BY  I.INS_CODE, EXTRACT(YEAR FROM I.RECEIVED_DATE), EXTRACT(MONTH FROM I.RECEIVED_DATE), INS_TYPE_CODE ORDER BY  I.CA_NO) INS_CODE_NO
                                FROM INFORM I
                                INNER JOIN STATUS S ON I.INFORM_ID = S.INFORM_ID
                                WHERE (INFORM_NO IS NOT NULL OR TXN_STATUS = 'VP')--existing + newly verified pass from front
                                          ) TMP WHERE TMP.INFORM_ID = INFORM.INFORM_ID
                                )
WHERE INFORM_ID IN (SELECT F.INFORM_ID
                                      FROM FRONT F INNER JOIN STATUS S ON F.INFORM_ID = S.INFORM_ID
                                      WHERE (TXN_STATUS = 'VP')
                                      );

END;
