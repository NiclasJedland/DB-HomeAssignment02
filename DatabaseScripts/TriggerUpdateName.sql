SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Niclas
-- Create date: 
-- Description:	
-- =============================================
CREATE TRIGGER TriggerUpdateName 
   ON Customers 
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	INSERT INTO ContactNameChange ([OldContactName],[NewContactName], [TimeOfUpdate])
		SELECT d.ContactName, i.ContactName, GETDATE()
			FROM inserted i
			INNER JOIN deleted d ON i.CustomerID = d.CustomerID

END
GO
