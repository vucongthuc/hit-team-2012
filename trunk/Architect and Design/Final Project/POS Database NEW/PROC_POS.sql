-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Giang Nguyen
-- Create date: 23/06/2012
-- Description:	Procedure will create an id increase automatic when add new category
-- =============================================
CREATE PROC SP_CATEGORY
	@CATEGORY_NAME NVARCHAR(50)
AS
BEGIN
	DECLARE @CATEGORY_ID VARCHAR(9)
	DECLARE @MAX INT

	IF NOT EXISTS (SELECT 1 FROM CATEGORY
							WHERE SUBSTRING(CATEGORY_ID,1,2)= 'CA')
		BEGIN
			SET @CATEGORY_ID = 'CA'+ '0001'
		END

	ELSE
		BEGIN
			SET @MAX = (SELECT MAX(RIGHT(CATEGORY_ID,4) )FROM CATEGORY WHERE SUBSTRING(CATEGORY_ID,1,2)= 'CA')
			SET @MAX = @MAX+1
			SET @CATEGORY_ID = RIGHT('000' + CONVERT(VARCHAR(4),@MAX),4)
		END
	INSERT INTO CATEGORY  VALUES (@CATEGORY_ID,@CATEGORY_NAME)

END
GO

	-- ======================================--======================================--
--=======================================PRODUCT======================================== --
	-- ======================================--======================================--
CREATE PROC SP_PRODUCT(@PRODUCT_NAME NVARCHAR(50), @BASICCOST FLOAT, @CATEGORY_ID VARCHAR(9))
AS
BEGIN
	DECLARE @PRODUCT_ID VARCHAR(9)
	DECLARE @MAX INT

	IF NOT EXISTS (SELECT 1 FROM PRODUCT
							WHERE SUBSTRING(@PRODUCT_ID,1,2)= 'PR')
		BEGIN
			SET @PRODUCT_ID = 'PR'+ '0001'
		END

	ELSE
		BEGIN
			SET @MAX = (SELECT MAX(RIGHT(@PRODUCT_ID,4) )FROM PRODUCT WHERE SUBSTRING(PRODUCT_ID,1,2)= 'CA')
			SET @MAX = @MAX+1
			SET @PRODUCT_ID = RIGHT('000' + CONVERT(VARCHAR(4),@MAX),4)
		END
	INSERT INTO PRODUCT  VALUES (@PRODUCT_ID,@PRODUCT_NAME,@BASICCOST,@CATEGORY_ID)
	

END
GO

	-- ======================================--======================================--
--=======================================SP_RETAILSTORE======================================== --
	-- ======================================--======================================--
CREATE PROC SP_RETAILSTORE
			@RETAILSTORE_NAME NVARCHAR(50)
AS
BEGIN
	DECLARE @RETAILSTORE_ID VARCHAR(9)
	DECLARE @MAX INT

	IF NOT EXISTS (SELECT 1 FROM RETAILSTORE
							WHERE SUBSTRING(@RETAILSTORE_ID,1,2)= 'RE')
		BEGIN
			SET @RETAILSTORE_ID = 'RE'+ '0001'
		END

	ELSE
		BEGIN
			SET @MAX = (SELECT MAX(RIGHT(@RETAILSTORE_ID,4) )FROM RETAILSTORE WHERE SUBSTRING(RETAILSTORE_ID,1,2)= 'RE')
			SET @MAX = @MAX+1
			SET @RETAILSTORE_ID = RIGHT('000' + CONVERT(VARCHAR(4),@MAX),4)
		END
	INSERT INTO RETAILSTORE  VALUES (@RETAILSTORE_ID,@RETAILSTORE_NAME)
END
GO


	-- ======================================--======================================--
--=======================================SP_USER======================================== --
	-- ======================================--======================================--
--CREATE PROC SP_USER
--			(@USER_ADDRESS	NVARCHAR(50),	
--					@USER_NAME	NVARCHAR(50),
--						@USER_PHONE	VARCHAR(15),
--							@PASSWORD	VARCHAR(32)	,
--								@RETAILSTORE_ID	VARCHAR(9))
						
--AS
--BEGIN
--	DECLARE @USER_ID VARCHAR(9)
--	DECLARE @MAX INT

--	IF NOT EXISTS (SELECT 1 FROM [USER]
--							WHERE SUBSTRING( [USER_ID],1,2)= 'US')
--		BEGIN
--			SET  @USER_ID = 'US'+ '0001'
--		END

--	ELSE
--		BEGIN
--			SET @MAX = (SELECT MAX(RIGHT(@USER_ID,4) )FROM [USER] WHERE SUBSTRING([USER_ID],1,2)= 'RE')
--			SET @MAX = @MAX+1
--			SET @USER_ID= RIGHT('000' + CONVERT(VARCHAR(4),@MAX),4)
--		END
--	INSERT INTO [USER]  VALUES (@USER_ID, @USER_ADDRESS, @USER_NAME, @USER_PHONE, @PASSWORD, @RETAILSTORE_ID)
--END
--GO

	-- ======================================--======================================--
--=======================================BILL======================================== --
	-- ======================================--======================================--
CREATE PROC SP_BILL
					(@COMPUTER_MAC VARCHAR(17),
						@CUSTOMER_ID VARCHAR(9)	,
							@USER_ID VARCHAR (9) ,
								@TOTALCOST FLOAT ,
									@DATE DATETIME ,
										@PLUSPOINT INT ,
											@MINUSPOINT INT )
						
AS
BEGIN
	DECLARE @BILL_ID VARCHAR(9)
	DECLARE @MAX INT

	IF NOT EXISTS (SELECT 1 FROM BILL
							WHERE SUBSTRING( BILL_ID,1,2)= 'BI')
		BEGIN
			SET  @BILL_ID = 'BI'+ '0001'
		END

	ELSE
		BEGIN
			SET @MAX = (SELECT MAX(RIGHT(@BILL_ID,4) )FROM BILL WHERE SUBSTRING(BILL_ID,1,2)= 'BI')
			SET @MAX = @MAX+1
			SET @BILL_ID= RIGHT('000' + CONVERT(VARCHAR(4),@MAX),4)
		END
	INSERT INTO BILL  VALUES (@BILL_ID, @COMPUTER_MAC, @CUSTOMER_ID, @USER_ID, @TOTALCOST, 
	@DATE, @PLUSPOINT, @MINUSPOINT)
END
GO
							
	-- ======================================--======================================--
--=======================================USER======================================== --
	-- ======================================--======================================--
CREATE PROC SP_USER
@USER_ADDRESS VARCHAR(50), 
@USER_NAME VARCHAR(50), 
@USER_PHONE VARCHAR(15),
@USER_BUSSINESS VARCHAR(15),
@RETAILSTORE_ID VARCHAR(9)
AS
BEGIN
 	DECLARE @STAFF_ID VARCHAR(6)
	DECLARE @MAX INT
	
	IF NOT EXISTS (SELECT 1 FROM [USER] )
	BEGIN
		SET @STAFF_ID = SUBSTRING(@USER_BUSSINESS,0,3) + '0001'
	END
	ELSE
	BEGIN
		SET @MAX = (SELECT MAX (RIGHT(USER_ID,4)) FROM [USER] )
		SET @MAX = @MAX+1
		SET @STAFF_ID = SUBSTRING(@USER_BUSSINESS,0,3) + RIGHT('0000'+CONVERT(VARCHAR(4),@MAX),4)
	END

	INSERT INTO [USER] VALUES (@STAFF_ID, @USER_ADDRESS, @USER_NAME, @USER_PHONE, @STAFF_ID, @RETAILSTORE_ID)
END

--DELETE FROM [USER] WHERE USER_ID = 'AD000'
EXEC SP_USER N'115/28 Trần Đình Xu, Q1, Tp.HCM', 'Giang Nguyen', '01656002722','CASHIER' ,'RE0001'
EXEC SP_USER N'116 Trần Đình Xu, Q1, Tp.HCM', 'Huy Huynh', '01656002722','MANAGER' ,'RE0001'
SELECT * FROM [USER]

EXEC SP_CATEGORY 'BEAR'
SELECT * FROM CATEGORY

EXEC SP_PRODUCT 'HEINEKEN', '15000', 'CA0001'
SELECT * FROM PRODUCT

EXEC SP_RETAILSTORE 'ABC Store'
SELECT * FROM RETAILSTORE

EXEC SP_USER N'115/28 Trần Đình Xu, Q1, Tp.HCM', 'Giang Nguyen', '01656002722', 'poshit', 'RE0001'
SELECT * FROM [USER]

EXEC SP_BILL '00:A0:C9:14:C8:29', 'CU0001', 'US0001', '200000', '06/06/2012', '200', '0'
SELECT * FROM BILL