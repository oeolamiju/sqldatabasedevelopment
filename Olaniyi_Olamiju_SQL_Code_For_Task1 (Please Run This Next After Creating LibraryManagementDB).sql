USE LibraryManagementDB;
GO

--The first set of queries create the required, normalized tables in the database

CREATE TABLE Users
(
  UserId INT IDENTITY NOT NULL PRIMARY KEY,
  Username NVARCHAR(50) NOT NULL UNIQUE,
  [HashedPassword] BINARY(32) NOT NULL,
  DoB DATE NOT NULL,
  Email NVARCHAR(100) UNIQUE NOT NULL CHECK (Email LIKE '%@%._%'),
  CreatedDate DATETIME default GETDATE(),
  UserModifiedDate DATETIME NULL,
  IsDeleted TINYINT Default 0  
);

CREATE TABLE UserProfiles
(
	UserProfileId INT IDENTITY NOT NULL PRIMARY KEY,
	UserId INT NOT NULL FOREIGN KEY REFERENCES Users(UserId),
	FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
	AddressLine1 NVARCHAR(50) NOT NULL,
	AddressLine2 NVARCHAR(50) NULL,
	MobileNumber VARCHAR(20) NULL,
	City NVARCHAR(50) NOT NULL,
	County NVARCHAR(50) NULL,
	PostCode NVARCHAR(10) NOT NULL,
	Country NVARCHAR(50) NOT NULL,
	IsDeleted TINYINT Default 0
);

CREATE TABLE ItemType
(
	ItemTypeId INT IDENTITY NOT NULL PRIMARY KEY,
	[ItemType] NVARCHAR(20) NOT NULL,
	[Description] NVARCHAR(50) NULL,
	IsDeleted TINYINT Default 0
);

CREATE TABLE ItemStatus
(
	ItemStatusId INT IDENTITY NOT NULL PRIMARY KEY,
	[CurrentStatus] NVARCHAR(20) NOT NULL,
	[Description] NVARCHAR(50) NULL,
	IsDeleted TINYINT Default 0
);

CREATE TABLE Items
(
  ItemId INT IDENTITY NOT NULL PRIMARY KEY,
  ItemTypeId INT NOT NULL FOREIGN KEY REFERENCES ItemType(ItemTypeId),
  ItemStatusId INT NOT NULL FOREIGN KEY REFERENCES ItemStatus(ItemStatusId),
  Title NVARCHAR(100) NOT NULL,
  Author NVARCHAR(50) NULL,
  Producer NVARCHAR (50) NULL,  
  YearOfPublicationOrProduction INT NOT NULL,
  ISBN NVARCHAR(20) NULL,
  ItemCreatedDate DATETIME default GETDATE(),
  ItemLostOrRemovedDate DATETIME NULL,
  ItemModifiedDate DATETIME NULL,
  IsDeleted TINYINT Default 0
);

 CREATE TABLE UserItemLoans
 (
	UserItemsLoanId INT IDENTITY NOT NULL PRIMARY KEY,
	UserId INT NOT NULL FOREIGN KEY REFERENCES Users(UserId),
    ItemId INT NOT NULL FOREIGN KEY REFERENCES Items(ItemId),
	LoanDate DATETIME default GETDATE(),
	DueDate DATETIME NOT NULL,
	ReturnedDate DATETIME NULL
 );
 
 CREATE TABLE PaymentMethods
 (
	PaymentMethodId INT IDENTITY NOT NULL PRIMARY KEY,
	PaymentMethod VARCHAR (20),
	[Description] NVARCHAR (50)
 );

 CREATE TABLE PaymentRecords
 (
	PaymentRecordId INT IDENTITY NOT NULL PRIMARY KEY,
	CreatedDate DATETIME DEFAULT GETDATE(),
	PaymentMethodId INT NOT NULL FOREIGN KEY REFERENCES PaymentMethods(PaymentMethodId),
	UserItemLoanId INT NOT NULL FOREIGN KEY REFERENCES UserItemLoans(UserItemsLoanId),
	AmountPaid MONEY NOT NULL
 )

 --This table below stores information of deleted users from the database. 
 --The required columns are automatically populated once the trigerr 'trig_DeletedUser' fires.

 CREATE TABLE User_Archived
(
	UserId INT NOT NULL PRIMARY KEY,
	Username NVARCHAR(50) NOT NULL,
	Email NVARCHAR(100) UNIQUE NOT NULL CHECK (Email LIKE '%@%._%'),
	CreatedDate DATETIME default GETDATE(),
	UserModifiedDate DATETIME default GETDATE()
);

--The next query inserts ten records into the Users table

 INSERT INTO [dbo].[Users] ([Username],[HashedPassword],[DoB],[Email],[CreatedDate],[UserModifiedDate],[IsDeleted])
 VALUES ('Kilimanjaro1', HASHBYTES('SHA2_256','sweetness#12'), '1987-04-05', 'kasowool@gmail.com', '2021-09-02 08:56:32:000', NULL, 0),
		('Elizabetha', HASHBYTES('SHA2_256','domin543'), '1998-12-11', 'elizabethaj@gmail.com', '2021-09-02 23:12:09:000', NULL, 0),
		('Niniola1', HASHBYTES('SHA2_256','sonth432'), '1988-10-19', 'niniola1234@gmail.com', '2023-01-30 14:21:08:000', NULL, 0),
		('Zualakate', HASHBYTES('SHA2_256','simon#98'), '1981-04-28', 'simeon0987@gmail.com', '2015-03-16 13:27:18:000', NULL, 0),
		('LoverofGod', HASHBYTES('SHA2_256','Jenskin654'), '2002-07-12', 'lovetteecode@gmail.com', '2022-11-08 05:34:51:000', NULL,  0),
		('Peteruman', HASHBYTES('SHA2_256','s567gaskiya'), '1999-09-19', 'peter4show@gmail.com', '2019-09-09 16:03:10:000', '2023-02-11 13:34:21:000', 1),
		('Rukayatu', HASHBYTES('SHA2_256','omodara43'), '1984-11-22', 'zingabon@gmail.com', '2015-02-27 01:17:28:000', NULL, 0),
		('Taskman', HASHBYTES('SHA2_256','colona10'), '1996-05-08', 'saintmill@gmail.com', '2018-06-17 19:45:59:000', NULL, 0),
		('Shabilolo', HASHBYTES('SHA2_256','reliance@1'), '2004-07-23', 'makfason23@yahoo.co.uk', '2022-10-29 12:06:53:000', NULL, 0),
		('Broadiman', HASHBYTES('SHA2_256','santana100'), '2000-12-30', 'graceful@hotmail.com', '2023-01-02 21:40:20:000', NULL, 0);


--The next query inserts ten records into the UserProfiles table

INSERT INTO [dbo].[UserProfiles] ([UserId],[FirstName],[LastName],[AddressLine1],[AddressLine2],[MobileNumber],[City],[County],[PostCode],[Country],[IsDeleted])
VALUES (1, 'Norman', 'Sadonic', '456 Loius St', NULL, '786-432-0371', 'Shyna', 'Bullshire', 'BGT Y78', 'England', 0),
	   (2, 'Elizabeth', 'Hajjia', '185 Gbana St', 'Katan Avenue', '883-908-1232', 'Celindion', 'Kokashire', 'CDR F56', 'England', 0), 
	   (3, 'Simeone', 'Solaski', '21 Karabo St', NULL, '657-098-9085', 'Boston', 'Kreman', 'KJN O67', 'Wales', 0), 
	   (4, 'Niniola', 'Faajilawa', '90 Futux St', 'Off Rangers Close', NULL, 'Gurrow', 'Horseshire', 'GTS L07', 'England', 0),
	   (5, 'Lovette', 'Justman', '56 Huban St', NULL, '127-543-9803', 'Lonton', 'Cantony', 'CGD M89', 'Scotland', 0), 
	   (6, 'Peter', 'Oluwafemi', '7 Olam St', NULL, NULL, 'Drubble', 'Jutgad', 'JNB S32', 'Ireland', 1),
	   (7, 'Rukayat', 'Imonmon', '390 Upperlake St', 'Harbinger Ave', '321-999-8454', 'Alumshire', 'Farnthol', 'FVC B10', 'Wales', 0),
	   (8, 'Saintmark', 'Churchill', '12 Mango St', NULL, '119-222-6730', 'Cassava', 'Guyan', 'GXZ P73', 'Scotland', 0),
	   (9, 'Mcpherson', 'Jonathan', '281 Sides St', NULL, NULL, 'Thuran', 'Hilton', 'HFE I65', 'England', 0),
	   (10, 'Gracious', 'Faithfilled', '145 Albert St', NULL, '786-432-0371', 'Bolton', 'Lancashire', 'BL4 S19', 'England', 0);

--The next query inserts 4 records into the ItemType table
INSERT INTO [dbo].[ItemType] ([ItemType], [Description])
VALUES ('Book', 'This item is a book with ISBN'),
	   ('Journal', 'This item is a journal'),
	   ('Other Media', 'This item is part of the media collection'),
	   ('DVD', 'This item is a DVD');

--The next query inserts 3 records into the ItemStatus table

INSERT INTO [dbo].[ItemStatus] ([CurrentStatus], [Description])
VALUES ('Available', 'This item is currently available in the library'),
	   ('LostOrRemoved', 'This item is either lost or removed'),
	   ('On Loan', 'This item is currently on loan to a member');

--The next query inserts ten records into the Items table

INSERT INTO  [dbo].[Items] ([ItemTypeId],[ItemStatusId],[Title],[Author],[Producer],[YearOfPublicationOrProduction],[ISBN],[ItemCreatedDate],[ItemLostOrRemovedDate],[ItemModifiedDate],[IsDeleted])
VALUES (1, 1, 'James On The Run 2', 'Chris Fowler', NULL, '2016', '2735590984627', '2017-01-11 14:09:12.000', NULL, NULL, 0),
	   (1, 1, 'James On The Run', 'Chris Fowler', NULL, '2015', '2736590284027', '2016-07-19 14:09:12.000', NULL, NULL, 0),
	   (1, 3, 'Catch Me If You Can', 'Surna Brown', NULL, '2001', '2336591289627', '2018-02-14 17:13:55.000', NULL, NULL, 0),
	   (2, 1, 'The Case Of HydrogenPeroxide For A Water Soluble Explosive', 'Peter Crowe', NULL, '2012', NULL, '2018-11-30 14:16:00.000', NULL, NULL, 0),
	   (4, 3, 'The Omage', NULL, 'Dames Fletchley', '2017', NULL, '2020-01-29 07:10:03.000', NULL, NULL, 0),
	   (3, 1, 'Lead Like A CEO', NULL, 'Brandon Lee', '1978', NULL, '2022-02-11 19:37:17.000', NULL, NULL, 0),
	   (1, 3, 'Make Me Happy', 'Paul Bryant', NULL, '2021', '9764325027156', '1990-04-17 17:49:26.000', NULL, NULL, 0),
	   (2, 3, 'Lonliness As A Barrier to Effective Psychomosis', 'Charles Prince', NULL, '2013', NULL, '2014-08-30 06:25:55.000', NULL, NULL, 0),
	   (3, 2, 'Visions Of The Night', NULL, 'John Baptista', '2000', NULL, '2010-05-16 17:04:29.000', '2013-06-23 21:47:16.000', NULL, 1),
	   (4, 3, 'The Guardian Magazine', NULL, 'Stone Fart', '2023', NULL, '2023-01-05 20:15:38.000', NULL, NULL, 0),
	   (1, 3, 'Beautiful Me', 'John Baptista', NULL, '2000', '7492836509734', '2010-05-16 18:01:06.000', NULL, NULL, 0);
	   
--The next query inserts ten records into the UserItemLoans table

INSERT INTO [dbo].[UserItemLoans] ([UserId], [ItemId], [LoanDate], [DueDate], [ReturnedDate])
VALUES (1, 1, '2022-09-12 03:08:02:000', '2023-03-28 03:09:45:000', '2023-04-13 17:03:44.000'),
	   (2, 2, '2023-02-04 17:34:18:000', '2023-04-18 12:38:43:000', '2023-04-16 12:18:22:000'),
	   (3, 3, '2022-12-06 04:22:19:000', '2023-04-19 14:19:17:000', NULL),
	   (4, 4, '2023-01-10 16:08:44:000', '2023-04-12 04:29:10.000', '2023-04-15 16:41:50:000'),
	   (5, 5, '2023-02-04 23:15:03:000', '2023-04-18 16:41:50:000', NULL),
	   (6, 6, '2023-02-04 06:25:19:000', '2023-04-03 18:23:50:000', '2023-04-03 18:23:50:000'),
	   (7, 7, '2022-12-06 19:05:58:000', '2023-04-17 10:20:30:000', NULL),
	   (8, 8,  '2022-10-02 11:31:04:000', '2023-04-20 06:02:00:000', NULL),
	   (9, 10, '2023-01-29 22:08:55:000', '2023-04-16 00:25:18:000', NULL),
	   (10, 11, '2022-12-30 21:17:02:000', '2023-06-05 09:33:53:000', NULL);
	   
--The next query inserts two records into the PaymentMethods table
INSERT INTO [dbo].[PaymentMethods]
VALUES ('Cash', 'Payment was made via cash deposit'),
	   ('Card', 'Payment was made via card transfer');

--The next query inserts ten records into the PaymentRecords table

INSERT INTO [dbo].[PaymentRecords]
VALUES ('2023-04-12 03:09:45:000', 2, 7, '0.12'),
       ('2023-04-13 09:42:08.000', 1, 9, '0.15'),
	   ('2023-04-11 00:25:18:000', 1, 5, '0.05');


GO

--The stored procedure query below is the solution to part (2a) of Task 1.
--The query can be checked using the following query: EXEC sp_findItemsByTitle 'James on the run'.

CREATE PROCEDURE [dbo].[sp_findItemsByTitle]
(@search NVARCHAR(50))
AS 
BEGIN
 SELECT * FROM Items WHERE Title like '%' + @search + '%' ORDER BY YearOfPublicationOrProduction DESC
END;

GO

--The stored procedure query below is the solution to part (2b) of Task 1..
--The query can be checked using the following query: EXEC sp_itemsWithLessThanFiveDaysOverdue.

CREATE PROCEDURE [dbo].[sp_itemsWithLessThanFiveDaysOverdue]
AS
BEGIN

	--Itemstatusid = 3 for items on loan 
SELECT it.ItemId, it.Title, it.Producer, it.YearOfPublicationOrProduction, it.Author, i.ItemType, it.CurrentStatus, 
	CASE 
		WHEN l.DueDate > GETDATE() THEN NULL
		ELSE DATEDIFF(day, l.DueDate, GETDATE())
	END AS DaysOverdue
FROM 
	(SELECT x.ItemId, x.Title, x.Producer, x.YearOfPublicationOrProduction, x.Author, x.ItemTypeId, u.CurrentStatus 
	FROM 
		(SELECT i.ItemId, i.Author,i.Title, i.Producer, i.YearOfPublicationOrProduction, i.ItemStatusId, i.ItemTypeId
		FROM Items i 
		LEFT JOIN UserItemLoans l ON i.ItemId = l.ItemId 
		WHERE DATEDIFF(DAY, l.DueDate, GETDATE()) < 5) x 
	LEFT JOIN ItemStatus u ON x.ItemStatusId = u.ItemStatusId 
	WHERE u.ItemStatusId = 3) it 
LEFT JOIN ItemType i on it.ItemTypeId = i.ItemTypeId 
LEFT JOIN UserItemLoans l on it.ItemId = l.ItemId
ORDER BY Title ASC

END;

GO

--The stored procedure query below is the solution to part (2c) of Task 1..

CREATE PROCEDURE [dbo].[sp_InsertNewMember]
(
    @username NVARCHAR(50),
    @password BINARY(32),
    @dob DATE,
    @email NVARCHAR(100),
    @firstName NVARCHAR(50),
    @lastName NVARCHAR(50),
    @addressLine1 NVARCHAR(50),
    @addressLine2 NVARCHAR(50) = NULL,
    @mobileNumber VARCHAR(20) = NULL,
    @city NVARCHAR(50),
    @county VARCHAR(50) = NULL,
    @postCode NVARCHAR(10),
    @country NVARCHAR(50),
    @isDeleted TINYINT = 0
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @userId INT;

    -- Insert the new user into the Users table
    INSERT INTO Users (Username, HashedPassword, DOB, Email, IsDeleted)
    VALUES (@username, @password, @dob, @email, @isDeleted);

    SET @userId = SCOPE_IDENTITY();

    -- Insert the user's profile into the UserProfiles table
    INSERT INTO UserProfiles (UserId, FirstName, LastName, AddressLine1, AddressLine2, MobileNumber, City, County, PostCode, Country, IsDeleted)
    VALUES (@userId, @firstName, @lastName, @addressLine1, @addressLine2, @mobileNumber, @city, @county, @postCode, @country, @isDeleted);
END;


GO

--The stored procedure query below is the solution to part (2d) of Task 1.

CREATE PROCEDURE [dbo].[sp_UpdateMember]
(
    @userId INT, @username NVARCHAR(50), @dob DATE, @email NVARCHAR(100), @firstName NVARCHAR(50),  @lastName NVARCHAR(50),  @addressLine1 NVARCHAR(50),
    @addressLine2 NVARCHAR(50) = NULL, @mobileNumber VARCHAR(20) = NULL, @city NVARCHAR(50), @county VARCHAR(50) = NULL, @postCode NVARCHAR(10),
    @country NVARCHAR(50),
    @isDeleted TINYINT = 0
)
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the user's record in the Users table
    UPDATE Users 
    SET Username = @username,
        DoB = @dob,
        Email = @email,
        UserModifiedDate = GETDATE(),
        IsDeleted = @isDeleted
    WHERE UserId = @userId;

    -- Update the user's profile in the UserProfiles table
    UPDATE UserProfiles 
    SET FirstName = @firstName,
        LastName = @lastName,
        AddressLine1 = @addressLine1,
        AddressLine2 = @addressLine2,
        MobileNumber = @mobileNumber,
        City = @city,
        County = @county,
        PostCode = @postCode,
        Country = @country,
        IsDeleted = @isDeleted
    WHERE UserId = @userId;
END;

GO

--The view query below is the solution to part (3) of Task 1..
--The view can be checked by heading over to the views folder under the LibraryManagementDB 
--and selecting the top 1000 rows while the cursor is on the view's name.

CREATE VIEW view_borrowedItemsAndDetails
AS
	SELECT
		l.UserItemsLoanId, i.Title, i.YearOfPublicationOrProduction, i.Producer, i.Author, i.ItemCreatedDate,
		i.ISBN, s.ItemStatusId, l.LoanDate AS BorrowedDate, l.DueDate,
		CASE
			WHEN DueDate >= GETDATE() AND s.ItemStatusId = 3 THEN NULL
			ELSE 0.1 * DATEDIFF(DAY, l.DueDate, GETDATE())
			END AS AssociatedFine
		FROM
			UserItemLoans l
			INNER JOIN Items i ON l.ItemId = i.ItemId
			LEFT JOIN PaymentRecords pr ON l.UserItemsLoanId = pr.UserItemLoanId
			LEFT JOIN ItemStatus s ON i.ItemStatusId = s.ItemStatusId
		WHERE
			l.ReturnedDate IS NULL
			AND i.IsDeleted = 0
			AND s.ItemStatusId = 3
		GROUP BY
			l.UserItemsLoanId, i.Title, i.YearOfPublicationOrProduction, i.Producer, i.Author,
			i.ItemCreatedDate, i.ISBN, s.ItemStatusId, l.LoanDate, l.DueDate
			

GO

--The trigger query below is the solution to part (4) of Task 1..

CREATE TRIGGER trg_UserItemLoanOnReturned
ON [UserItemLoans]

AFTER UPDATE
AS 
	BEGIN
		SET NOCOUNT ON;
		IF UPDATE (ReturnedDate)
		BEGIN
	--Itemstatus = 1 is Available
		UPDATE Items 
		SET ItemStatusId = 1
		FROM Items i 
		inner join UserItemLoans u on u.ItemId = i.ItemId
		where i.ItemStatusId != 1 and u.ReturnedDate is not null
	END
END;

GO
--The user-defined scalar-valued function below is the solution to part (5) of Task 1..
--The function can checked by running the following query: Select dbo.func_TotalLoansByDate('2023-02-04') as TotalLoansAtDate
CREATE FUNCTION [dbo].[func_TotalLoansByDate]   
(@date Date) Returns INT

As 
	Begin
	Declare @count int;

	SELECT @count = COUNT(*) FROM UserItemLoans where Cast(LoanDate as Date) = @date 
	return @count
END;

GO

--The additional queries below were added in response to Part (7) of Task 1
--The view below shows the repayments made abd the corresponding outstanding balance.
CREATE VIEW [dbo].[v_userItemLoanPayments] 

AS

SELECT 
  UIL.UserItemsLoanId, 
  PR.CreatedDate AS PaymentDate, 
  PM.PaymentMethod,
  PR.AmountPaid,
  (SELECT SUM(AmountPaid) FROM PaymentRecords WHERE UserItemLoanId = UIL.UserItemsLoanId) AS TotalPaidAmount,
  (SELECT COUNT(*) FROM PaymentRecords WHERE UserItemLoanId = UIL.UserItemsLoanId) AS PaymentCount,
  (SELECT DueDate FROM UserItemLoans WHERE UserItemsLoanId = UIL.UserItemsLoanId) AS DueDate,
  (SELECT 0.1 * DATEDIFF(DAY, UIL.DueDate, GETDATE()) - ISNULL(SUM(AmountPaid), 0) FROM PaymentRecords WHERE UserItemLoanId = UIL.UserItemsLoanId) AS OutstandingBalance
	FROM UserItemLoans UIL
	INNER JOIN PaymentRecords PR ON UIL.UserItemsLoanId = PR.UserItemLoanId
	INNER JOIN PaymentMethods PM ON PR.PaymentMethodId = PM.PaymentMethodId
	INNER JOIN Users U ON UIL.UserId = U.UserId


GO

--the trigger below fires and updates the [dbo].[User_Archived] table whenever a member's record is deleted.

CREATE TRIGGER trig_DeletedUser
ON Users
AFTER DELETE
AS
BEGIN

    INSERT INTO User_Archived
    (UserId, Username, Email, CreatedDate, UserModifiedDate)
    SELECT
        d.UserId,
		d.Username,
        d.Email,
        d.CreatedDate,
        d.UserModifiedDate

    FROM deleted d;

    -- Update the UserProfiles table to set the user as deleted
    UPDATE UserProfiles
    SET IsDeleted = 1
    WHERE UserId IN (SELECT UserId FROM deleted);
END;
