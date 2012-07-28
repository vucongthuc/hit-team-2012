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

-- =============================================
-- Author:		Giang Nguyen
-- Create date: 27/07/2012
-- Description:	Procedure will create an id increase automatic when add new category
-- =============================================

	-- ======================================--======================================--
--==========================================DEPARTMENT======================================== --
	-- ======================================--======================================--
CREATE PROC SP_INSERT_DEPARTMENT
				@DEPARTMENT_NAME	nvarchar(50)
				

AS
BEGIN
	DECLARE @DEPARTMENTID VARCHAR(15)
	DECLARE @MAX INT
	
	IF NOT EXISTS (SELECT 1 FROM DEPARTMENT )
	BEGIN
		SET @DEPARTMENTID = 'DE0001'
	END
	ELSE
	BEGIN
		SET @MAX = (SELECT MAX (RIGHT(DEPARTMENTID,4)) FROM DEPARTMENT )
		SET @MAX = @MAX+1
		SET @DEPARTMENTID = 'DE' + RIGHT('000'+CONVERT(VARCHAR(4),@MAX),4)
	END

	INSERT INTO DEPARTMENT VALUES (@DEPARTMENTID,@DEPARTMENT_NAME,'TRUE')
END
GO


----------------------------------------------------------------------------------------------------------
-------------------------------------------SEARCHING---------------------------------------------------------
----------------------------------------------------------------------------------------------------------
GO							

-- =============================================
-- Author:		Huy Huynh
-- Create date: 28/07/2012
-- Description:
-- =============================================

	-- ======================================--======================================--
--==========================================USER======================================== --
	-- ======================================--======================================--
CREATE PROC SP_SEARCH_USER
AS
BEGIN
	SELECT [USERID],[USER_NAME], [PASSWORD], A.[AUTHORITYID],AUTHORITY_NAME
	FROM dbo.[USER] U, dbo.AUTHORITY A
	WHERE A.[AUTHORITYID] = U.[AUTHORITYID] AND USER_STATUS = 'TRUE'
END
GO

	-- ======================================--======================================--
--==========================================DEPARTMENT======================================== --
	-- ======================================--======================================--
CREATE PROC SP_SEARCH_DEPARTMENT
AS
BEGIN
	SELECT DEPARTMENTID, DEPARTMENT_NAME
	FROM dbo.DEPARTMENT
	WHERE DEPARTMENT_STATUS = 'TRUE'
END
GO

--SEARCH USER
EXEC SP_SEARCH_USER

--SEARCH DEPARTMENT
EXEC SP_SEARCH_DEPARTMENT

--INSERT DATA BASE
INSERT INTO dbo.AUTHORITY VALUES ('AU0001','Administrator')
INSERT INTO dbo.AUTHORITY VALUES ('AU0002','The Faculty Monitor')
INSERT INTO dbo.AUTHORITY VALUES ('AU0003','The Received Student Record Officer')
INSERT INTO dbo.AUTHORITY VALUES ('AU0004','The Training Department Officer')
INSERT INTO dbo.AUTHORITY VALUES ('AU0005','The Human Resource Department Officer')
INSERT INTO dbo.AUTHORITY VALUES ('AU0006','The Management Committee')

INSERT INTO DEPARTMENT VALUES ('0','0','FALSE')
EXEC SP_INSERT_DEPARTMENT 'IT'
GO
INSERT INTO [USER] VALUES('225514633','ADMIN',N'Chân Tình',N'115/28 Trần Đình Xu, Q1','01656002722','Nam','Admin','True','True','0','AU0001')
--THỰC THI CÁC HÀM SELECT
SELECT * FROM DEPARTMENT
GO
SELECT * FROM [USER]
GO
SELECT * FROM AUTHORITY
GO

