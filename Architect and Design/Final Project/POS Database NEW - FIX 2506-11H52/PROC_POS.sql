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

----------------------------------------------------------------------------------------------------------
-------------------------------------------INSERT---------------------------------------------------------
----------------------------------------------------------------------------------------------------------
GO							
	-- ======================================--======================================--
--==========================================USER======================================== --
	-- ======================================--======================================--
CREATE PROC SP_INSERT_USER
@USER_ADDRESS VARCHAR(50), 
@USER_NAME VARCHAR(50), 
@USER_PHONE VARCHAR(15),
@USER_BUSSINESS VARCHAR(15),
@RETAILSTOREID VARCHAR(9)
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
		SET @MAX = (SELECT MAX (RIGHT(USERID,4)) FROM [USER] )
		SET @MAX = @MAX+1
		SET @STAFF_ID = SUBSTRING(@USER_BUSSINESS,0,3) + RIGHT('0000'+CONVERT(VARCHAR(4),@MAX),4)
	END

	INSERT INTO [USER] VALUES (@STAFF_ID, @USER_ADDRESS, @USER_NAME, @USER_PHONE, @STAFF_ID, @RETAILSTOREID,'TRUE')
END
GO

-- =============================================
-- Author:		HUY HUYNH
-- Create date: 27/06/2012
-- Description:	Procedure will create an id increase automatic when add new category
-- =============================================
CREATE PROC SP_INSERT_CATEGORY
@CATEGORY_NAME NVARCHAR(50)
AS
BEGIN
	DECLARE @CATEGORYID VARCHAR(9)
	DECLARE @MAX INT
	
	IF NOT EXISTS (SELECT 1 FROM CATEGORY )
	BEGIN
		SET @CATEGORYID = 'CA0001'
	END
	ELSE
	BEGIN
		SET @MAX = (SELECT MAX (RIGHT(CATEGORYID,4)) FROM CATEGORY )
		SET @MAX = @MAX+1
		SET @CATEGORYID = 'CA' + RIGHT('000'+CONVERT(VARCHAR(4),@MAX),4)
	END

	INSERT INTO CATEGORY VALUES (@CATEGORYID,@CATEGORY_NAME,'TRUE')
END
GO

	-- ======================================--======================================--
--=======================================SP_RETAILSTORE======================================== --
	-- ======================================--======================================--
CREATE PROC SP_INSERT_RETAILSTORE
@RETAILSTORE_NAME NVARCHAR(50)
AS
BEGIN
	DECLARE @RETAILSTOREID VARCHAR(9)
	DECLARE @MAX INT
	
	IF NOT EXISTS (SELECT 1 FROM CATEGORY )
	BEGIN
		SET @RETAILSTOREID = 'RE0001'
	END
	ELSE
	BEGIN
		SET @MAX = (SELECT MAX (RIGHT(CATEGORYID,4)) FROM CATEGORY )
		SET @MAX = @MAX+1
		SET @RETAILSTOREID = 'RE' + RIGHT('000'+CONVERT(VARCHAR(4),@MAX),4)
	END

	INSERT INTO RETAILSTORE VALUES (@RETAILSTOREID,@RETAILSTORE_NAME,'TRUE')
END
GO

	-- ======================================--======================================--
--=======================================BILL======================================== --
	-- ======================================--======================================--
CREATE PROC SP_INSERT_BILL
					(@COMPUTERMAC VARCHAR(17),
						@CUSTOMERID VARCHAR(9)	,
							@USERID VARCHAR (9) ,
								@TOTALCOST FLOAT ,
									@DATE DATETIME ,
										@PLUSPOINT INT ,
											@MINUSPOINT INT )
						
AS
BEGIN
	DECLARE @BILLID VARCHAR(9)
	DECLARE @MAX INT

	IF NOT EXISTS (SELECT 1 FROM BILL )
	BEGIN
		SET @BILLID = 'BI0001'
	END

	ELSE
		BEGIN
			SET @MAX = (SELECT MAX (RIGHT(BILLID,4)) FROM BILL )
			SET @MAX = @MAX+1
			SET @BILLID = 'BI' + RIGHT('000'+CONVERT(VARCHAR(4),@MAX),4)
		END
	INSERT INTO BILL  VALUES (@BILLID, @COMPUTERMAC, @CUSTOMERID, @USERID, @TOTALCOST, 
	@DATE, @PLUSPOINT, @MINUSPOINT)
END
GO

	-- ======================================--======================================--
--=======================================PRODUCT======================================== --
	-- ======================================--======================================--
CREATE PROC SP_INSERT_PRODUCT(@PRODUCT_NAME NVARCHAR(50), @BASICCOST FLOAT, @CATEGORYID VARCHAR(9), @STOCK INT)
AS
BEGIN
	DECLARE @PRODUCTID VARCHAR(9)
	DECLARE @MAX INT

	IF NOT EXISTS (SELECT 1 FROM PRODUCT)
		BEGIN
			SET @PRODUCTID = 'PR'+ '0001'
		END

	ELSE
		BEGIN
			SET @MAX = (SELECT MAX(RIGHT(PRODUCTID,4) )FROM PRODUCT)
			SET @MAX = @MAX+1
			SET @PRODUCTID = 'PR'+RIGHT('000' + CONVERT(VARCHAR(4),@MAX),4)
		END
	INSERT INTO PRODUCT  VALUES (@PRODUCTID,@PRODUCT_NAME,@BASICCOST,@CATEGORYID,'TRUE',@STOCK)
END
GO

	-- ======================================--======================================--
--=======================================CUSTOMER======================================== --
	-- ======================================--======================================--
CREATE PROC SP_INSERT_CUSTOMER(@ID VARCHAR(9),@NAME NVARCHAR(50), @ADDRESS NVARCHAR(50), @PHONE VARCHAR(15),@SUMPOINT INT)
AS
BEGIN
	INSERT INTO CUSTOMER  VALUES (@ID,@NAME,@ADDRESS,@PHONE,@SUMPOINT,'TRUE')
END
GO

	-- ======================================--======================================--
--=======================================COMPUTER======================================== --
	-- ======================================--======================================--
CREATE PROC SP_INSERT_COMPUTER(@COMID VARCHAR(17),@RETAILSTOREID VARCHAR(9))
AS
BEGIN
	INSERT INTO COMPUTER  VALUES (@COMID,@RETAILSTOREID,'TRUE')
END
GO

	-- ======================================--======================================--
--=======================================BILL DETAIL======================================== --
	-- ======================================--======================================--
CREATE PROC SP_INSERT_BILLDETAIL(@BILLID VARCHAR(9),@PRODUCTID VARCHAR(9), @QUANTITY INT)
AS
BEGIN
	INSERT INTO BILL_DETAIL  VALUES (@BILLID,@PRODUCTID,@QUANTITY)
END
GO

	-- ======================================--======================================--
--=======================================COST======================================== --
	-- ======================================--======================================--
CREATE PROC SP_INSERT_COST(@PRODUCTID VARCHAR(9),@RETAILSTOREID VARCHAR(9), @DATESTART DATETIME, @DATEEND DATETIME, @COST FLOAT)
AS
BEGIN
	INSERT INTO COST VALUES (@PRODUCTID,@RETAILSTOREID,@DATESTART,@DATEEND,@COST)
END
GO

	-- ======================================--======================================--
--=======================================RETAILSTORE_CATEGORY======================================== --
	-- ======================================--======================================--
CREATE PROC SP_INSERT_RETAILSTORECATEGORY(@CATEGORYID VARCHAR(9),@RETAILSTOREID VARCHAR(9), @QUANTITY INT)
AS
BEGIN
	INSERT INTO RETAILSTORE_CATEGORY VALUES (@CATEGORYID,@RETAILSTOREID,@QUANTITY)
END
GO

--------------------------------------------------------------------------------------------------------------
--------------------------------------------UPDATE------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
GO
	-- ======================================--======================================--
--==========================================USER======================================== --
	-- ======================================--======================================--
CREATE PROC SP_UPDATE_USER
@USERID VARCHAR(9),
@USER_ADDRESS VARCHAR(50), 
@USER_NAME VARCHAR(50), 
@USER_PHONE VARCHAR(15),
@USER_PASSWORD VARCHAR(15),
@RETAILSTOREID VARCHAR(9),
@STATUS BIT
AS
BEGIN
 	UPDATE [USER]
 	SET USER_ADDRESS = @USER_ADDRESS,
 		USER_PHONE = @USER_PHONE,
 		[PASSWORD] = @USER_PASSWORD,
 		RETAILSTOREID = @RETAILSTOREID,
 		USSTATUS = @STATUS,
 		USER_NAME = @USER_NAME
 	WHERE USERID = @USERID
END
GO

-- =============================================
-- Author:		HUY HUYNH
-- Create date: 27/06/2012
-- Description:	Procedure will create an id increase automatic when add new category
-- =============================================
CREATE PROC SP_UPDATE_CATEGORY
@CATEGORYID VARCHAR(9),
@CATEGORY_NAME NVARCHAR(50),
@STATUS BIT
AS
BEGIN
	UPDATE CATEGORY
	SET	CATEGORY_NAME = @CATEGORY_NAME,
		CASTATUS = @STATUS
	WHERE CATEGORYID = @CATEGORYID
END
GO

	-- ======================================--======================================--
--=======================================SP_RETAILSTORE======================================== --
	-- ======================================--======================================--
CREATE PROC SP_UPDATE_RETAILSTORE
@RETAILSTOREID VARCHAR(9),
@RETAILSTORE_NAME NVARCHAR(50),
@STATUS BIT
AS
BEGIN
	UPDATE RETAILSTORE
	SET	RETAILSTORE_NAME = @RETAILSTORE_NAME,
		RESTATUS = @STATUS
	WHERE RETAILSTOREID = @RETAILSTOREID
END
GO

	-- ======================================--======================================--
--=======================================PRODUCT======================================== --
	-- ======================================--======================================--
CREATE PROC SP_UPDATE_PRODUCT(@PRODUCTID VARCHAR(9),@PRODUCT_NAME NVARCHAR(50), @BASICCOST FLOAT, @CATEGORYID VARCHAR(9),@STATUS BIT, @STOCK INT)
AS
BEGIN
	UPDATE	PRODUCT
	SET	PRODUCT_NAME = @PRODUCT_NAME,
		BASICCOST = BASICCOST,
		CATEGORYID = @CATEGORYID,
		PRSTATUS = @STATUS,
		STOCK = @STOCK
	WHERE	PRODUCTID = @PRODUCTID
END
GO


	-- ======================================--======================================--
--=======================================CUSTOMER======================================== --
	-- ======================================--======================================--
CREATE PROC SP_UPDATE_CUSTOMER(@ID VARCHAR(9),@NAME NVARCHAR(50), @ADDRESS NVARCHAR(50), @PHONE VARCHAR(15),@SUMPOINT INT, @STATUS BIT)
AS
BEGIN
	UPDATE CUSTOMER
	SET CUSTOMER_NAME = @NAME,
		CUSTOMER_ADDRESS = @ADDRESS,
		CUSTOMER_PHONE = @PHONE,
		SUMPOINT = @SUMPOINT,
		CUSTATUS = @STATUS
	WHERE	CUSTOMERID = @ID	
END
GO

	-- ======================================--======================================--
--=======================================COMPUTER======================================== --
	-- ======================================--======================================--
CREATE PROC SP_UPDATE_COMPUTER(@COMID VARCHAR(17),@RETAILSTOREID VARCHAR(9),@STATUS BIT)
AS
BEGIN
	UPDATE COMPUTER
	SET RETAILSTOREID = @RETAILSTOREID,
		COSTATUS = @STATUS
	WHERE	COMPUTERMAC = @COMID
END
GO

--------------------------------------------------------------------------------------------------------------
--------------------------------------------SHOW UP------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
GO

	-- ======================================--======================================--
--==========================================USER======================================== --
	-- ======================================--======================================--
CREATE PROC SP_SHOW_USER
AS
BEGIN
	SELECT USERID, USER_ADDRESS, USER_NAME, USER_PHONE, PASSWORD, RETAILSTOREID
	FROM	[USER]
	WHERE USSTATUS = 'TRUE'
END
GO

-- =============================================
-- Author:		HUY HUYNH
-- Create date: 27/06/2012
-- Description:	Procedure will create an id increase automatic when add new category
-- =============================================
CREATE PROC SP_SHOW_CATEGORY
AS
BEGIN
	SELECT CATEGORYID, CATEGORY_NAME
	FROM CATEGORY
	WHERE CASTATUS ='TRUE'
END
GO

	-- ======================================--======================================--
--=======================================SP_RETAILSTORE======================================== --
	-- ======================================--======================================--
CREATE PROC SP_SHOW_RETAILSTORE
AS
BEGIN
	SELECT RETAILSTOREID, RETAILSTORE_NAME
	FROM RETAILSTORE
	WHERE	RESTATUS = 'TRUE'
END
GO

	-- ======================================--======================================--
--=======================================PRODUCT======================================== --
	-- ======================================--======================================--
CREATE PROC SP_SHOW_PRODUCT 
AS
BEGIN
	SELECT PRODUCTID, PRODUCT_NAME, BASICCOST, CATEGORYID, STOCK
	FROM PRODUCT
	WHERE	PRSTATUS ='TRUE'
END
GO

	-- ======================================--======================================--
--=======================================COMPUTER======================================== --
	-- ======================================--======================================--
CREATE PROC SP_SHOW_COMPUTER
AS
BEGIN
	SELECT COMPUTERMAC, RETAILSTOREID
	FROM COMPUTER
	WHERE COSTATUS = 'TRUE'
END
GO


	-- ======================================--======================================--
--=======================================CUSTOMER======================================== --
	-- ======================================--======================================--
CREATE PROC SP_SHOW_CUSTOMER
AS
BEGIN
	SELECT 	CUSTOMERID, CUSTOMER_NAME, CUSTOMER_ADDRESS, CUSTOMER_PHONE, SUMPOINT
	FROM CUSTOMER
	WHERE CUSTATUS = 'TRUE'
END
GO


--LƯU Ý:=============================================
--LƯU Ý: CHẠY TỪNG DÒNG 1 ĐỐI VỚI PHẦN ADD NÀY ======
--LƯU Ý:=============================================
---EXEC CÁC HÀM INSERT
EXEC SP_INSERT_CATEGORY 'BEAR'
GO
EXEC SP_INSERT_PRODUCT 'HEINEKEN', '15000', 'CA0001'
GO
EXEC SP_INSERT_RETAILSTORE 'ABC Store'
GO
EXEC SP_INSERT_COMPUTER '00:A0:C9:14:C8:29','RE0001'
GO
EXEC SP_INSERT_USER N'115/28 Tran Đinh Xu, Q1, Tp.HCM', 'Giang Nguyen', '01656002722','CASHIER' ,'RE0001'
GO
EXEC SP_INSERT_USER N'116 Tran Đinh Xu, Q1, Tp.HCM', 'Huy Huynh', '01656002722','MANAGER' ,'RE0001'
GO
EXEC SP_INSERT_CUSTOMER '0', N'Ảo Văn Lòi','0', '0', '0' 
GO
EXEC SP_INSERT_BILL '00:A0:C9:14:C8:29', '0', 'CA0001', '200000', '06/06/2012', '200', '0'
GO
EXEC SP_INSERT_BILLDETAIL 'BI0001','PR0001',10
GO

--EXEC CÁC HÀM UPDATE
EXEC SP_UPDATE_USER 'CA0001',N'115/28 Tran Đinh Xu, Q2, Tp.HCM', 'Giang Nguyen', '01656002722','123456' ,'RE0001','TRUE'
GO
EXEC SP_UPDATE_CATEGORY 'CA0001','DRINK','TRUE'
GO
EXEC SP_UPDATE_RETAILSTORE 'RE0001','DEF STORE','TRUE'
GO
EXEC SP_UPDATE_PRODUCT 'PR0001','TIGER', '15000', 'CA0001','TRUE'
GO
EXEC SP_UPDATE_CUSTOMER '0','0','0', '0', '0','TRUE'
GO
EXEC SP_UPDATE_COMPUTER '00:A0:C9:14:C8:29','RE0001','TRUE'
GO

--THỰC THI CÁC HÀM SELECT
SELECT * FROM CATEGORY
GO
SELECT * FROM PRODUCT
GO
SELECT * FROM RETAILSTORE
GO
SELECT * FROM COMPUTER
GO
SELECT * FROM [USER]
GO
SELECT * FROM CUSTOMER 
GO
SELECT * FROM BILL
GO

