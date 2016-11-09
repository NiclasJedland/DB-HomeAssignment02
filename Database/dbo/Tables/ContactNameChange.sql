CREATE TABLE [dbo].[ContactNameChange]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [OldContactName] NVARCHAR(50) NOT NULL, 
    [NewContactName] NVARCHAR(50) NOT NULL, 
    [TimeOfUpdate] DATETIME NOT NULL
)
