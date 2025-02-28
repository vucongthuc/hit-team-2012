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
USE SRM_PRO
GO

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
	SELECT [USERID], [PASSWORD], A.[AUTHORITYID],AUTHORITY_NAME
	FROM dbo.[USER] U, dbo.AUTHORITY A
	WHERE A.[AUTHORITYID] = U.[AUTHORITYID] AND USER_STATUS = 'TRUE'
END
GO

create PROC SP_SEARCH_FOR_PERMISSION
@USERID VARCHAR(9)
AS
BEGIN
	SELECT A.[AUTHORITYID],DEPARTMENTID
	FROM dbo.[USER] U, dbo.AUTHORITY A
	WHERE A.[AUTHORITYID] = U.[AUTHORITYID] AND USER_STATUS = 'TRUE' AND [USERID] = @USERID
END
GO

CREATE PROC SP_SEARCH_USER_FOR_WEB
@USERID VARCHAR(9)
AS
BEGIN
	SELECT USERID, [PASSWORD]
	FROM dbo.[USER] U, DEPARTMENT D
	WHERE USERID = @USERID AND U.DEPARTMENTID = D.DEPARTMENTID AND D.DEPARTMENT_STATUS = 'FALSE'
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

CREATE PROC SP_SEARCH_DEPARTMENT2
AS
BEGIN
	SELECT DEPARTMENTID, DEPARTMENT_NAME
	FROM dbo.DEPARTMENT
END
GO

CREATE PROC SP_SEARCH_DEPARTMENT_FOR_PERMISSION
@DEPARTMENTID VARCHAR(15)
AS
BEGIN
	SELECT DEPARTMENTID, DEPARTMENT_NAME
	FROM dbo.DEPARTMENT
	WHERE DEPARTMENT_STATUS = 'TRUE' AND @DEPARTMENTID = DEPARTMENTID
END
go

-- ======================================--======================================--
--==========================================STUDENT======================================== --
	-- ======================================--======================================--
CREATE PROC SP_SEARCH_STUDENTID
@STUDENTID VARCHAR(9)
AS
BEGIN
	SELECT	s.STUDENTID, STUDENT_NAME, STUDENT_DATEOFBIRTH,DEPARTMENT_NAME, BATCH, RECEIPTID
	FROM	dbo.STUDENT S, DEPARTMENT D, RECEIPT R
	WHERE	s.STUDENTID = @STUDENTID AND
			S.DEPARTMENTID = D.DEPARTMENTID AND
			S.STUDENTID = R.STUDENTID
END
GO
	-- ======================================--======================================--
--==========================================RECORD======================================== --
	-- ======================================--======================================--
CREATE PROC SP_SEARCH_RECORD
@STUDENTID VARCHAR(9)
AS
BEGIN
	SELECT	RE.RECORDID, RECORD_NAME, RECORD_STATUS, NOTE
	FROM	dbo.STUDENT S, dbo.RECORD RE, dbo.RECEIPT_DETAIL RD, dbo.RECEIPT RT
	WHERE	S.STUDENTID = @STUDENTID AND
			S.STUDENTID = RT.STUDENTID AND
			RT.RECEIPTID = RD.RECEIPTID AND
			RD.RECORDID = RE.RECORDID		
END
GO

CREATE PROC SP_SEARCH_RECORD_BY_DEPARTMENT
@STUDENTID VARCHAR(9),
@DEPARTMENTID VARCHAR(15)
AS
BEGIN
	SELECT	RE.RECORDID, RECORD_NAME, RECORD_STATUS, NOTE
	FROM	dbo.STUDENT S, dbo.RECORD RE, dbo.RECEIPT_DETAIL RD, dbo.RECEIPT RT
	WHERE	S.STUDENTID = @STUDENTID AND
			S.STUDENTID = RT.STUDENTID AND
			RT.RECEIPTID = RD.RECEIPTID AND
			RD.RECORDID = RE.RECORDID	AND
			S.DEPARTMENTID = @DEPARTMENTID
END
GO

	-- ======================================--======================================--
--==========================================RECEIPT======================================== --
	-- ======================================--======================================--
CREATE PROC SP_SEARCH_RECEIPT
@STUDENTID VARCHAR(9)
AS
BEGIN
	SELECT	RECEIPTID
	FROM	dbo.RECEIPT
	WHERE	@STUDENTID = STUDENTID
END
GO

CREATE PROC SP_SEARCH_RECEIPT_UPDATENUMBER
@STUDENTID VARCHAR(9)
AS
BEGIN
	SELECT	NUMBEROFUPDATE
	FROM	dbo.RECEIPT
	WHERE	@STUDENTID = STUDENTID
END
GO

	-- ======================================--======================================--
--==========================================DEPARTMENT_BY_AUTHORITY========================================== --
	-- ======================================--======================================--
CREATE PROC SP_SEARCH_DEPARTMENT_BY_AUTHORITY
@AUTHORITYID VARCHAR(15)
AS
BEGIN
	SELECT D.DEPARTMENTID, DEPARTMENT_NAME
	FROM dbo.DEPARTMENT D, dbo.AUTHORITY A, dbo.DEPARTMENT_AUTHORITY DA
	WHERE DA.DEPARTMENTID = D.DEPARTMENTID AND DA.AUTHORITYID = A.AUTHORITYID AND @AUTHORITYID = DA.AUTHORITYID 
END
GO

	-- ======================================--======================================--
--==========================================VIEW LOG======================================== --
	-- ======================================--======================================--
CREATE PROC SP_SHOWALL_VIEWLOG
AS
BEGIN
	SELECT [DATE],V.USERID, V.STUDENTID, STUDENT_NAME, [ACTION]
	FROM VIEWLOG V,dbo.STUDENT S
	WHERE V.STUDENTID = S.STUDENTID
END
GO

CREATE PROC SP_SEARCH_VIEWLOG_USERID
@USERID VARCHAR(9)
AS
BEGIN
	SELECT [DATE],V.USERID, V.STUDENTID, STUDENT_NAME, [ACTION]
	FROM VIEWLOG V,dbo.STUDENT S
	WHERE @USERID = V.USERID AND V.STUDENTID = S.STUDENTID
END
GO

CREATE PROC SP_SEARCH_VIEWLOG_USERID_DATE
@USERID VARCHAR(9),
@DATEFROM DATETIME,
@DATETO DATETIME
AS
BEGIN
	SELECT [DATE],V.USERID, V.STUDENTID, STUDENT_NAME, [ACTION]
	FROM VIEWLOG V,dbo.STUDENT S
	WHERE @USERID = V.USERID AND V.STUDENTID = S.STUDENTID AND [DATE]>= @DATEFROM AND [DATE]<=@DATETO
END
GO

CREATE PROC SP_SEARCH_VIEWLOG_DATE
@DATEFROM DATETIME,
@DATETO DATETIME
AS
BEGIN
	SELECT [DATE],V.USERID, V.STUDENTID, STUDENT_NAME, [ACTION]
	FROM VIEWLOG V,dbo.STUDENT S
	WHERE V.STUDENTID = S.STUDENTID AND [DATE]>= @DATEFROM AND [DATE]<=@DATETO
END
GO
----------------------------------------------------------------------------------------------------------
-------------------------------------------CREATE---------------------------------------------------------
----------------------------------------------------------------------------------------------------------
GO							

-- =============================================
-- Author:		Huy Huynh
-- Create date: 28/07/2012
-- Description:
-- =============================================
GO
	-- ======================================--======================================--
--==========================================STUDENT======================================== --
	-- ======================================--======================================--
--Import thông tin student vào
CREATE PROC SP_IMPORT_STUDENT_RECORD
@STUDENT_ID VARCHAR(9),
@STUDENT_NAME NVARCHAR(50),
@BATCH INT,
@DATEOFBIRTH DATETIME,
@STUDENT_GENDER NVARCHAR(5),
@STUDENT_ADDRESS NVARCHAR(200),
@DEPARTMENTID VARCHAR(15),
@USERID VARCHAR(9)
AS
BEGIN
	INSERT INTO STUDENT VALUES (@STUDENT_ID,@STUDENT_NAME,@BATCH,@STUDENT_ADDRESS,@STUDENT_GENDER,@DATEOFBIRTH,@DEPARTMENTID,@USERID)
END
GO

-- ======================================--======================================--
--==========================================RECIEPT======================================== --
	-- ======================================--======================================--
--Thêm record vào
--CREATE PROC SP_CREATE_STUDENT_RECEIPT
--@STUDENTID VARCHAR(9),
--@USERID VARCHAR(9),
--@DEPARTMENTID VARCHAR(9),
--@DATE_CREATED DATETIME
--AS
--BEGIN
--	DECLARE @RECEIPTID VARCHAR(10)
--	DECLARE @MAX INT
	
--	IF NOT EXISTS (SELECT 1 FROM RECEIPT )
--	BEGIN
--		SET @RECEIPTID = YEAR(@DATE_CREATED)+@DEPARTMENTID+'0001'
--	END
--	ELSE
--	BEGIN
--		SET @MAX = (SELECT MAX (RIGHT(RECEIPTID,4)) FROM RECEIPT )
--		SET @MAX = @MAX+1
--		SET @RECEIPTID = YEAR(@DATE_CREATED) + @DEPARTMENTID + RIGHT('000'+CONVERT(VARCHAR(4),@MAX),4)
--	END

--	INSERT INTO RECEIPT VALUES (@RECEIPTID,@STUDENTID,@USERID,@DATE_CREATED)
--END
--GO


create proc SP_CREATE_STUDENT_RECEIPT
@STUDENTID VARCHAR(9),
@USERID VARCHAR(9),
@DEPARTMENTID VARCHAR(9)
AS
BEGIN
	DECLARE @RECEIPTID VARCHAR(10)
	DECLARE @MAX INT
	
	IF NOT EXISTS (SELECT RECEIPTID FROM dbo.RECEIPT WHERE YEAR(GETDATE()) = 
						CONVERT(VARCHAR(4),SUBSTRING(RECEIPTID,1,4)))
		BEGIN
			SET @RECEIPTID = CONVERT(VARCHAR,( YEAR(GETDATE())))+@DEPARTMENTID+'0001'
		END
	ELSE
		BEGIN
			SET @MAX = (SELECT MAX (RIGHT(RECEIPTID,4)) FROM RECEIPT WHERE CONVERT(VARCHAR(4),LEFT(RECEIPTID,4)) = YEAR(GETDATE()))
			SET @MAX = @MAX+1
			SET @RECEIPTID = CONVERT(VARCHAR(4),YEAR(GETDATE())) + @DEPARTMENTID + RIGHT('000'+CONVERT(VARCHAR(4),@MAX),4)
		END
	INSERT INTO RECEIPT VALUES (@RECEIPTID,@STUDENTID,@USERID,GETDATE(),'',-1)
	
	SELECT RECEIPTID FROM RECEIPT WHERE RECEIPTID = @RECEIPTID
END
GO


-- ======================================--======================================--
--==========================================RECEIPT DETAIL======================================== --
	-- ======================================--======================================--
--Thêm record vào
CREATE PROC SP_CREATE_RECEIPT_DETAIL
@RECEIPTID VARCHAR(10)
AS
BEGIN
	INSERT INTO RECEIPT_DETAIL VALUES (@RECEIPTID,1,'FALSE','')
	INSERT INTO RECEIPT_DETAIL VALUES (@RECEIPTID,2,'FALSE','')
	INSERT INTO RECEIPT_DETAIL VALUES (@RECEIPTID,3,'FALSE','')
	INSERT INTO RECEIPT_DETAIL VALUES (@RECEIPTID,4,'FALSE','')
	INSERT INTO RECEIPT_DETAIL VALUES (@RECEIPTID,5,'FALSE','')
	INSERT INTO RECEIPT_DETAIL VALUES (@RECEIPTID,6,'FALSE','')
	INSERT INTO RECEIPT_DETAIL VALUES (@RECEIPTID,7,'FALSE','')
	INSERT INTO RECEIPT_DETAIL VALUES (@RECEIPTID,8,'FALSE','')
	INSERT INTO RECEIPT_DETAIL VALUES (@RECEIPTID,9,'FALSE','')
END
GO

-- ======================================--======================================--
--==========================================VIEW LOG======================================== --
	-- ======================================--======================================--
--Thêm record vào
CREATE PROC SP_CREATE_VIEWLOG
@USERID VARCHAR(9),
@STUDENTID VARCHAR(9),
@ACTION NVARCHAR(100)
AS
BEGIN
	DECLARE @MAX BIGINT
	
	IF NOT EXISTS (SELECT 1 FROM VIEWLOG )
	BEGIN
		SET @MAX = 1
	END
	ELSE
	BEGIN
		SET @MAX = (SELECT MAX (VIEWLOGID) FROM VIEWLOG )
		SET @MAX = @MAX+1
	END
	INSERT INTO VIEWLOG VALUES (@MAX,GETDATE(),@USERID,@STUDENTID,@ACTION)
END
GO

----------------------------------------------------------------------------------------------------------
-------------------------------------------UPDATE---------------------------------------------------------
----------------------------------------------------------------------------------------------------------
GO							

-- =============================================
-- Author:		Huy Huynh
-- Create date: 30/07/2012
-- Description:
-- =============================================
GO
	-- ======================================--======================================--
--==========================================USER======================================== --
	-- ======================================--======================================--

CREATE PROC SP_UPDATE_USER_LOGIN_ALLOWED
@USERID VARCHAR(9),
@STATUS BIT
AS
BEGIN
	update	[USER]
	set		USER_LOGINALOWED = @STATUS
	where	USERID = @USERID
END
GO

-- ======================================--======================================--
--==========================================RECEIPT DETAIL======================================== --
	-- ======================================--======================================--
--Thêm record vào
CREATE PROC SP_UPDATE_RECEIPT_DETAIL
@RECEIPTID VARCHAR(10),
@RECORDID INT,
@STATUS BIT,
@NOTE NVARCHAR(100)
AS
BEGIN
	UPDATE	RECEIPT_DETAIL
	SET		RECORD_STATUS = @STATUS,
			NOTE = @NOTE
	WHERE	@RECEIPTID = RECEIPTID AND
			@RECORDID = RECORDID
END
GO

-- ======================================--======================================--
--==========================================RECEIPT======================================== --
	-- ======================================--======================================--

create PROC SP_UPDATE_STUDENT_RECEIPT
@RECEIPTID VARCHAR(10)
AS
BEGIN
	DECLARE @RECEIPTIDTEMP VARCHAR(10)
	DECLARE @MAX INT
	
	IF NOT EXISTS (SELECT RECEIPTIDTEMP FROM dbo.RECEIPT WHERE YEAR(GETDATE()) = 
						CONVERT(VARCHAR(4),SUBSTRING(RECEIPTIDTEMP,1,4)))
		BEGIN
			SET @RECEIPTIDTEMP = CONVERT(VARCHAR,( YEAR(GETDATE())))+ SUBSTRING(@RECEIPTID,5,2) +'0001'
		END
	ELSE
		BEGIN
			SET @MAX = (SELECT MAX (RIGHT(RECEIPTIDTEMP,4)) FROM RECEIPT WHERE CONVERT(VARCHAR(4),LEFT(RECEIPTIDTEMP,4)) = YEAR(GETDATE()))
			SET @MAX = @MAX+1
			SET @RECEIPTIDTEMP = CONVERT(VARCHAR(4),YEAR(GETDATE())) + SUBSTRING(@RECEIPTID,5,2) + RIGHT('000'+CONVERT(VARCHAR(4),@MAX),4)
		END
	
	UPDATE 	RECEIPT
	SET		RECEIPTIDTEMP = @RECEIPTIDTEMP
	WHERE	RECEIPTID = @RECEIPTID
	
	SELECT RECEIPTIDTEMP FROM RECEIPT WHERE RECEIPTID = @RECEIPTID
END
go


CREATE PROC SP_UPDATE_STUDENT_RECEIPT_UPDATENUMBER
@RECEIPTID VARCHAR(10)
AS
BEGIN
	
	UPDATE 	RECEIPT
	SET		NUMBEROFUPDATE = NUMBEROFUPDATE+1
	WHERE	RECEIPTID = @RECEIPTID
	
	SELECT NUMBEROFUPDATE FROM RECEIPT WHERE RECEIPTID = @RECEIPTID
END
go

CREATE PROC SP_UPDATE_STUDENT_RECEIPT_UPDATEUSER
@RECEIPTID VARCHAR(10),
@USERID VARCHAR(9)
AS
BEGIN
	
	UPDATE 	RECEIPT
	SET		USERID = @USERID,
			DATE_CREATED = GETDATE()
	WHERE	RECEIPTID = @RECEIPTID
END
go

------------------------------------STATISTICS---------------------------------------------------
-- =============================================
-- Author:		Huy Huynh
-- Create date: 5/08/2012
-- Description: Mệt pà cố
-- =============================================

--Thống kê tổng số hồ sơ khoa nhận đc
CREATE PROC SP_STATISTICS_SUM_RECIEVED_RECORD_FOLLOW_DEPARTMENT
@DEPARTMENT VARCHAR(15)
AS
BEGIN
	SELECT	COUNT(*)AS [COUNT]
	FROM	dbo.DEPARTMENT D, dbo.RECEIPT R, dbo.STUDENT S
	WHERE	S.STUDENTID = R.STUDENTID AND 
			S.DEPARTMENTID = D.DEPARTMENTID AND 
			NUMBEROFUPDATE >= 0 AND
			@DEPARTMENT = D.DEPARTMENTID
END
GO

--Thống kê tổng số hồ sơ của khoa
CREATE PROC SP_STATISTICS_ALL_RECORD_FOLLOW_DEPARTMENT
@DEPARTMENT VARCHAR(15)
AS
BEGIN
	SELECT	COUNT(*)AS [COUNT]
	FROM	dbo.DEPARTMENT D, dbo.RECEIPT R, dbo.STUDENT S
	WHERE	S.STUDENTID = R.STUDENTID AND 
			S.DEPARTMENTID = D.DEPARTMENTID AND
			@DEPARTMENT = S.DEPARTMENTID
END
GO

--Thống kê tổng số hồ sơ toàn trường
CREATE PROC SP_STATISTICS_ALL_RECORD_FOLLOW_WHOLE_UNIVERCITY
AS
BEGIN
	SELECT	COUNT(*)AS [COUNT]
	FROM	dbo.RECEIPT
END
GO

--Thống kê hồ sơ nhận được toàn trường
CREATE PROC SP_STATISTICS_SUM_RECIEVED_RECORD_FOLLOW_WHOLE_UNIVERCITY
AS
BEGIN
	SELECT	COUNT(*)AS [COUNT]
	FROM	dbo.RECEIPT
	WHERE	NUMBEROFUPDATE >= 0
END
GO

--Thống kê theo số ngày theo khoa
CREATE PROC SP_STATISTICS_IN_DETAIL_FOLLOW_DAY_BYDEPARTMENT
@DAY INT,
@DEPARTMENT VARCHAR(15)
AS
BEGIN
	IF(@DEPARTMENT LIKE 'ALL')
	BEGIN
		IF(@DAY = 3)
			BEGIN
				SELECT	COUNT(*)AS [COUNT]
				FROM	dbo.RECEIPT
				WHERE	NUMBEROFUPDATE >= 0 AND 
						DAY(DATE_CREATED) >= (SELECT MAX(DAY(DATE_CREATED)) 
							FROM dbo.RECEIPT 
								WHERE NUMBEROFUPDATE >= 0)
			END
		ELSE IF(@DAY = 2)
			BEGIN
				SELECT	COUNT(*)AS [COUNT]
				FROM	dbo.RECEIPT
				WHERE	NUMBEROFUPDATE >= 0 AND 
						DAY(DATE_CREATED) > (SELECT MIN(DAY(DATE_CREATED)) 
							FROM dbo.RECEIPT 
								WHERE NUMBEROFUPDATE >= 0) AND
						DAY(DATE_CREATED) < (SELECT MAX(DAY(DATE_CREATED)) 
							FROM dbo.RECEIPT 
								WHERE NUMBEROFUPDATE >= 0)
			END
		ELSE
			BEGIN
				SELECT	COUNT(*)AS [COUNT]
				FROM	dbo.RECEIPT
				WHERE	NUMBEROFUPDATE >= 0 AND 
						DAY(DATE_CREATED) <= (SELECT MIN(DAY(DATE_CREATED)) 
								FROM dbo.RECEIPT 
									WHERE NUMBEROFUPDATE >= 0)
			END
	END
	ELSE
		BEGIN
			IF(@DAY = 3)
				BEGIN
					SELECT	COUNT(*)AS [COUNT]
					FROM	dbo.DEPARTMENT D, dbo.RECEIPT R, dbo.STUDENT S
					WHERE	NUMBEROFUPDATE >= 0 AND 
							S.STUDENTID = R.STUDENTID AND 
							S.DEPARTMENTID = D.DEPARTMENTID AND
							@DEPARTMENT = D.DEPARTMENTID AND
							DAY(DATE_CREATED) >= (SELECT MAX(DAY(DATE_CREATED)) 
								FROM dbo.RECEIPT 
									WHERE NUMBEROFUPDATE >= 0)
				END
			ELSE IF(@DAY = 2)
				BEGIN
					SELECT	COUNT(*)AS [COUNT]
					FROM	dbo.DEPARTMENT D, dbo.RECEIPT R, dbo.STUDENT S
					WHERE	NUMBEROFUPDATE >= 0 AND 
							S.STUDENTID = R.STUDENTID AND 
							S.DEPARTMENTID = D.DEPARTMENTID AND
							@DEPARTMENT = D.DEPARTMENTID AND
							DAY(DATE_CREATED) > (SELECT MIN(DAY(DATE_CREATED)) 
								FROM dbo.RECEIPT 
									WHERE NUMBEROFUPDATE >= 0) AND
							DAY(DATE_CREATED) < (SELECT MAX(DAY(DATE_CREATED)) 
								FROM dbo.RECEIPT 
									WHERE NUMBEROFUPDATE >= 0)
				END
		ELSE
			BEGIN
				SELECT	COUNT(*)AS [COUNT]
				FROM	dbo.DEPARTMENT D, dbo.RECEIPT R, dbo.STUDENT S
				WHERE	NUMBEROFUPDATE >= 0 AND
						S.STUDENTID = R.STUDENTID AND 
						S.DEPARTMENTID = D.DEPARTMENTID AND
						@DEPARTMENT = D.DEPARTMENTID AND
						DAY(DATE_CREATED) <= (SELECT MIN(DAY(DATE_CREATED)) 
								FROM dbo.RECEIPT 
									WHERE NUMBEROFUPDATE >= 0)
			END
		END		
END
GO


--Thống kê theo số ngày Theo user
CREATE PROC SP_STATISTICS_IN_DETAIL_FOLLOW_DAY_BY_USER
@DAY INT,
@USERID VARCHAR(9)
AS
BEGIN
	
		
			IF(@DAY = 3)
				BEGIN
					SELECT	COUNT(*)AS [COUNT]
					FROM	dbo.RECEIPT R
					WHERE	NUMBEROFUPDATE >= 0 AND 
							@USERID = R.USERID AND
							DAY(DATE_CREATED) >= (SELECT MAX(DAY(DATE_CREATED)) 
								FROM dbo.RECEIPT 
									WHERE NUMBEROFUPDATE >= 0)
				END
			ELSE IF(@DAY = 2)
				BEGIN
					SELECT	COUNT(*)AS [COUNT]
					FROM	dbo.RECEIPT R
					WHERE	NUMBEROFUPDATE >= 0 AND 
							@USERID = R.USERID AND
							DAY(DATE_CREATED) > (SELECT MIN(DAY(DATE_CREATED)) 
								FROM dbo.RECEIPT 
									WHERE NUMBEROFUPDATE >= 0) AND
							DAY(DATE_CREATED) < (SELECT MAX(DAY(DATE_CREATED)) 
								FROM dbo.RECEIPT 
									WHERE NUMBEROFUPDATE >= 0)
				END
		ELSE
			BEGIN
				SELECT	COUNT(*)AS [COUNT]
				FROM	dbo.RECEIPT R
				WHERE	NUMBEROFUPDATE >= 0 AND
						@USERID = R.USERID AND
						DAY(DATE_CREATED) <= (SELECT MIN(DAY(DATE_CREATED)) 
								FROM dbo.RECEIPT 
									WHERE NUMBEROFUPDATE >= 0)
			END
				
END
GO

--Tổng số hồ sơ mà user đó thực hiện
CREATE PROC SP_STATISTICS_BY_USER
@USERID VARCHAR(9)
AS
BEGIN
	SELECT	COUNT(*)AS [COUNT]
	FROM	dbo.RECEIPT
	WHERE	NUMBEROFUPDATE >= 0 AND @USERID= USERID
END
GO

--Lấy ngày cao nhất và thấp nhất
CREATE PROC SP_STATISTICS_DAY
@DAY INT
AS
BEGIN
	IF(@DAY = 1)
		BEGIN
			SELECT CONVERT(varchar,DATE_CREATED,101) AS [_DATE] FROM RECEIPT
			WHERE DAY(DATE_CREATED)=
			(SELECT MIN(DAY(DATE_CREATED)) 
								FROM dbo.RECEIPT 
									WHERE NUMBEROFUPDATE >= 0)
			GROUP BY CONVERT(varchar,DATE_CREATED,101)
		END
	ELSE IF(@DAY = 2)
		BEGIN
			SELECT CONVERT(varchar,DATE_CREATED,101) AS [_DATE] FROM RECEIPT
			WHERE DAY(DATE_CREATED)<
			(SELECT MAX(DAY(DATE_CREATED)) 
								FROM dbo.RECEIPT 
									WHERE NUMBEROFUPDATE >= 0) AND
			DAY(DATE_CREATED)>
			(SELECT MIN(DAY(DATE_CREATED)) 
								FROM dbo.RECEIPT 
									WHERE NUMBEROFUPDATE >= 0)					
			GROUP BY CONVERT(varchar,DATE_CREATED,101)
		END
	ELSE
		BEGIN
			SELECT CONVERT(varchar,DATE_CREATED,101) AS [_DATE] FROM RECEIPT
			WHERE DAY(DATE_CREATED)=
			(SELECT MAX(DAY(DATE_CREATED)) 
								FROM dbo.RECEIPT 
									WHERE NUMBEROFUPDATE >= 0)
			GROUP BY CONVERT(varchar,DATE_CREATED,101)
		END
END
GO

exec SP_STATISTICS_DAY 3
---------------------------------------------------------------------------------------------------


--INSERT DATA BASE
---------------------------------------------AUTHORITY-------------------------------------------
INSERT INTO dbo.AUTHORITY VALUES ('AU0001','Admin')
INSERT INTO dbo.AUTHORITY VALUES ('AU0002',N'Trưởng Khoa')
INSERT INTO dbo.AUTHORITY VALUES ('AU0003',N'Nhân Viên Nhận Hồ Sơ')
INSERT INTO dbo.AUTHORITY VALUES ('AU0004',N'Phòng Đào Tạo')
INSERT INTO dbo.AUTHORITY VALUES ('AU0005',N'Phòng Nhân Lực')
INSERT INTO dbo.AUTHORITY VALUES ('AU0006',N'Ban Giám Hiệu')

---------------------------------------------DEPARTMENT-------------------------------------------
INSERT INTO DEPARTMENT VALUES ('HIGH',N'Tài khoản cấp cao','FALSE')
INSERT INTO DEPARTMENT VALUES ('AX',N'Kiến trúc Xây dựng','TRUE')
INSERT INTO DEPARTMENT VALUES ('NN',N'Ngoại ngữ','TRUE')
INSERT INTO DEPARTMENT VALUES ('MC',N'Mỹ thuật Công nghiệp','TRUE')
INSERT INTO DEPARTMENT VALUES ('SH',N'Công nghệ Sinh học','TRUE')
INSERT INTO DEPARTMENT VALUES ('MT',N'Công nghệ & Quản lý Môi trường','TRUE')
INSERT INTO DEPARTMENT VALUES ('DA',N'Điện lạnh','TRUE')
INSERT INTO DEPARTMENT VALUES ('DL',N'Du lịch','TRUE')
INSERT INTO DEPARTMENT VALUES ('TH',N'Công nghệ Thông tin','TRUE')
INSERT INTO DEPARTMENT VALUES ('TC',N'Ban Trung học Chuyên nghiệp','TRUE')
INSERT INTO DEPARTMENT VALUES ('FB',N'Tài chính Ngân hàng','TRUE')
INSERT INTO DEPARTMENT VALUES ('KT',N'Kế toán - Kiểm toán','TRUE')
INSERT INTO DEPARTMENT VALUES ('CO',N'Thương Mại','TRUE')
INSERT INTO DEPARTMENT VALUES ('QT',N'Quản trị Kinh doanh','TRUE')
INSERT INTO DEPARTMENT VALUES ('PR',N'Quan hệ Công chúng & Truyền thông','TRUE')

---------------------------------------------DEPARTMENT_AUTHORITY-------------------------------------------
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('HIGH','AU0001')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('HIGH','AU0004')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('HIGH','AU0005')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('HIGH','AU0006')

INSERT INTO DEPARTMENT_AUTHORITY VALUES ('AX','AU0002')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('NN','AU0002')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('MC','AU0002')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('SH','AU0002')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('MT','AU0002')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('DA','AU0002')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('DL','AU0002')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('TH','AU0002')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('TC','AU0002')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('FB','AU0002')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('KT','AU0002')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('CO','AU0002')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('QT','AU0002')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('PR','AU0002')

INSERT INTO DEPARTMENT_AUTHORITY VALUES ('AX','AU0003')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('NN','AU0003')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('MC','AU0003')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('SH','AU0003')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('MT','AU0003')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('DA','AU0003')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('DL','AU0003')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('TH','AU0003')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('TC','AU0003')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('FB','AU0003')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('KT','AU0003')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('CO','AU0003')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('QT','AU0003')
INSERT INTO DEPARTMENT_AUTHORITY VALUES ('PR','AU0003')

---------------------------------------------[USER]-------------------------------------------
INSERT INTO [USER] VALUES('ADMIN',N'Chân Tình','2/9/1991', N'115/28 Trần Đình Xu, Q1','01656002722','Nam','Admin','True','True','HIGH','AU0001')
INSERT INTO [USER] VALUES('365925282',N'Baby Sunshine','1/11/1991', N'7/14 Nguyễn Khắc Nhu, Q1','01679246288','Nam','123','True','True','TH','AU0002')
INSERT INTO [USER] VALUES('BGH',N'Cùi Quang Hiệp', '9/22/1991', N'112 Cống Quỳnh, Q1','0153968742',N'Nữ','123','True','True','HIGH','AU0006')
INSERT INTO [USER] VALUES('NHANLUC',N'Nguyễn Trần Hồng Phúc', '7/15/1991', N'113 Cống Quỳnh, Q1','0153968746',N'Nam','123','True','True','HIGH','AU0005')
INSERT INTO [USER] VALUES('DAOTAO',N'Trần Dũng Đạt', '5/25/1991', N'13 Cống Quỳnh, Q1','0153968741',N'Nam','123','True','True','HIGH','AU0004')
INSERT INTO [USER] VALUES('225514634',N'Giang Thị Hà Thanh', '8/3/1991', N'24 Cống Quỳnh, Q1','0153458742',N'Nam','123','True','True','AX','AU0003')
INSERT INTO [USER] VALUES('365925283',N'Trần Như Nhộng', '5/2/1991', N'113 Cống Quỳnh, Q1','0156968742',N'Nam','123','True','True','TH','AU0003')
INSERT INTO [USER] VALUES('225514633',N'Trần Chân', '12/2/1991', N'113 Cống Quỳnh, Q1','0155668742',N'Nữ','123','True','True','AX','AU0002')

---------------------------------------------RECORD-------------------------------------------
INSERT INTO dbo.RECORD VALUES (1,N'Giấy báo trúng tuyển')
INSERT INTO dbo.RECORD VALUES (2,N'Học bạ THPT (Bản photo có kèm bản chính)')
INSERT INTO dbo.RECORD VALUES (3,N'Bằng tốt nghiệp PTTH, BTTH, giấy CNTN tạm thời (Bản photo kèm theo bản chính đối chiếu)')
INSERT INTO dbo.RECORD VALUES (4,N'Giấy khai sinh (Bản photo có kèm bản chính)')
INSERT INTO dbo.RECORD VALUES (5,N'Giấy tờ xác định đối tượng và khu vực ưu tiên')
INSERT INTO dbo.RECORD VALUES (6,N'Hộ khẩu thường trú (Bản photo có kèm bản chính)')
INSERT INTO dbo.RECORD VALUES (7,N'Hồ sơ chuyển sinh hoạt đoàn')
INSERT INTO dbo.RECORD VALUES (8,N'04 phong bì dán tem ghi rõ địa chỉ gia đình')
INSERT INTO dbo.RECORD VALUES (9,N'Đã chụp ảnh thẻ tại trường')

--THỰC THI CÁC HÀM SELECT
SELECT * FROM DEPARTMENT
GO
SELECT * FROM AUTHORITY
GO
SELECT * FROM DEPARTMENT_AUTHORITY
GO
SELECT * FROM [USER]
GO
SELECT * FROM STUDENT
GO
SELECT * FROM RECORD
GO

--SEARCH USER
EXEC SP_SEARCH_USER
GO
--SEARCH DEPARTMENT
EXEC SP_SEARCH_DEPARTMENT
GO

update [user]
set USER_LOGINALOWED='true'
where USERID = 'admin'

