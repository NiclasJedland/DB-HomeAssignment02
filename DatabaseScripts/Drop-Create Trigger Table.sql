USE [NORTHWND]
GO

/****** Object:  Table [dbo].[ContactNameChange]    Script Date: 2016-11-02 22:30:59 ******/
DROP TABLE [dbo].[ContactNameChange]
GO

/****** Object:  Table [dbo].[ContactNameChange]    Script Date: 2016-11-02 22:30:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ContactNameChange](
	[NameChangeID] [int] IDENTITY(1,1) NOT NULL,
	[OldContactName] [nvarchar](30) NOT NULL,
	[NewContactName] [nvarchar](30) NOT NULL,
	[TimeOfUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_ContactNameChange] PRIMARY KEY CLUSTERED 
(
	[NameChangeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


