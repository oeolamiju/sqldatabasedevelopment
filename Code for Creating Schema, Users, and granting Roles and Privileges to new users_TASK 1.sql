
--Creating a different secure schema for security purposes
CREATE SCHEMA Financial_Director;
GO

--Securing some of the database objects (tables) in a different schmema
ALTER SCHEMA Financial_Director TRANSFER [dbo].[UserItemLoans]
ALTER SCHEMA Financial_Director TRANSFER [dbo].[PaymentRecords]
ALTER SCHEMA Financial_Director TRANSFER [dbo].[PaymentRecords]

--Creating a new user for the database
CREATE LOGIN Shakitibobo
WITH PASSWORD = 'djsegvwdue20!';--Granting access to the new database user- ShakitiboboCREATE USER Shakitibobo FOR LOGIN Shakitibobo;
GO--Granting multiple priviliges to new database user - ShakitiboboGRANT SELECT, INSERT, DELETE, UPDATE ON [dbo].[UserProfiles] TO
Shakitibobo WITH GRANT OPTION;