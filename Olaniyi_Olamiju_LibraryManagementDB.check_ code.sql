
--Ensuring that that the Library management database backup can be restored (T-SQL)

BACKUP DATABASE LibraryManagementDB
TO DISK ='C:\LibraryManagementDB_Backup\LibraryManagementDBcheck.bak' 
WITH CHECKSUM

--This can be combined with the command RESTORE VERIFYONLY to ensure not only that a
--backup is not corrupted but that it can be restored.

RESTORE VERIFYONLY 
FROM DISK = 'C:\LibraryManagementDB_Backup\LibraryManagementDBcheck.bak' 
WITH CHECKSUM;