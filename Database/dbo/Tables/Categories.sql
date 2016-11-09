CREATE TABLE [dbo].[Categories] (
    [CategoryID]   INT           IDENTITY (1, 1) NOT NULL,
    [CategoryName] NVARCHAR (15) NOT NULL,
    [Description]  NTEXT         NULL,
    [Picture]      IMAGE         NULL,
    CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([CategoryID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [CategoryName]
    ON [dbo].[Categories]([CategoryName] ASC);


GO
-- =============================================
-- Author:		Niclas
-- Create date: 
-- Description:	
-- =============================================
CREATE TRIGGER CategoryUpdateTrigger 
   ON Categories 
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here

	INSERT INTO CategoryNameChanges (CategoryID, OldCategoryName, NewCategoryName)
		SELECT i.CategoryID, d.CategoryName, i.CategoryName
			FROM inserted i
			INNER JOIN deleted d ON i.CategoryID = d.CategoryID

END
