USE [master]
GO
/****** Object:  Database [CinemaDatabase]    Script Date: 3/30/2016 4:53:21 PM ******/
CREATE DATABASE [CinemaDatabase]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CinemaDatabase', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.ARTEMMAZUR\MSSQL\DATA\CinemaDatabase.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CinemaDatabase_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.ARTEMMAZUR\MSSQL\DATA\CinemaDatabase_log.ldf' , SIZE = 8384KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CinemaDatabase] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CinemaDatabase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CinemaDatabase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CinemaDatabase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CinemaDatabase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CinemaDatabase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CinemaDatabase] SET ARITHABORT OFF 
GO
ALTER DATABASE [CinemaDatabase] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CinemaDatabase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CinemaDatabase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CinemaDatabase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CinemaDatabase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CinemaDatabase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CinemaDatabase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CinemaDatabase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CinemaDatabase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CinemaDatabase] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CinemaDatabase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CinemaDatabase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CinemaDatabase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CinemaDatabase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CinemaDatabase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CinemaDatabase] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CinemaDatabase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CinemaDatabase] SET RECOVERY FULL 
GO
ALTER DATABASE [CinemaDatabase] SET  MULTI_USER 
GO
ALTER DATABASE [CinemaDatabase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CinemaDatabase] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CinemaDatabase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CinemaDatabase] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [CinemaDatabase] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'CinemaDatabase', N'ON'
GO
USE [CinemaDatabase]
GO
/****** Object:  UserDefinedFunction [dbo].[AverageMovieRating]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AverageMovieRating] (@movieId int)
returns float
as
	begin
	return
		(select AVG(Rate) from Ratings where MovieId = @movieId)
	end


GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Accounts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](128) NOT NULL,
	[Email] [varchar](128) NOT NULL,
	[IsAdmin] [bit] NOT NULL,
	[IsBlocked] [bit] NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[Salt] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MovieId] [int] NOT NULL,
	[AccountId] [int] NOT NULL,
	[CommentText] [nvarchar](max) NOT NULL,
	[DateTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GenreLocalization]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GenreLocalization](
	[GenreId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[GenreId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Genres]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genres](
	[Id] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Halls]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Halls](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](128) NOT NULL,
	[HallPicture] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Languages]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Languages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MovieLocalization]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieLocalization](
	[MovieId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[MovieId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MoviePersonsJunction]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MoviePersonsJunction](
	[MovieId] [int] NOT NULL,
	[PersonId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MovieId] ASC,
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Movies]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Movies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Length] [int] NOT NULL,
	[GenreId] [int] NULL,
	[ReleaseDate] [datetime] NOT NULL,
	[DirectorId] [int] NULL,
	[Rating]  AS ([dbo].[AverageMovieRating]([Id])),
	[PhotoId] [int] NULL,
	[VideoLink] [varchar](max) NULL,
	[IsDeleted] [bit] NOT NULL DEFAULT ((0)),
	[RemoveExecutorId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PersonLocalization]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonLocalization](
	[PersonId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Persons]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Persons](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PhotoId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Photos]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Photos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Path] [nvarchar](max) NOT NULL,
	[GUID] [uniqueidentifier] NOT NULL,
	[Filename] [nvarchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Profiles]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profiles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Surname] [nvarchar](128) NOT NULL,
	[Phone] [varchar](15) NULL,
	[ImageData] [varbinary](max) NULL,
	[AccountId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ratings]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ratings](
	[Rate] [int] NOT NULL,
	[AccountId] [int] NOT NULL,
	[MovieId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountId] ASC,
	[MovieId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Seances]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seances](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[HallId] [int] NOT NULL,
	[MovieId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SeatTypes]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SeatTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](8) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sectors]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sectors](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FromRow] [int] NOT NULL,
	[ToRow] [int] NOT NULL,
	[FromPlace] [int] NOT NULL,
	[ToPlace] [int] NOT NULL,
	[SectorTypeId] [int] NOT NULL,
	[HallId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SectorTypePrices]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SectorTypePrices](
	[SectorTypeId] [int] NOT NULL,
	[SeanceId] [int] NOT NULL,
	[Price] [decimal](18, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SectorTypeId] ASC,
	[SeanceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SecurityToken]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SecurityToken](
	[Id] [uniqueidentifier] NOT NULL,
	[AccountId] [int] NOT NULL,
	[ResetRequestDateTime] [datetime] NOT NULL,
	[IsUsed] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TicketPreOrders]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TicketPreOrders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Row] [int] NOT NULL,
	[Place] [int] NOT NULL,
	[AccountId] [int] NULL,
	[SeanceId] [int] NOT NULL,
	[DateTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TicketPreOrdersDeleted]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TicketPreOrdersDeleted](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Row] [int] NOT NULL,
	[Place] [int] NOT NULL,
	[AccountId] [int] NULL,
	[SeanceId] [int] NOT NULL,
	[DateTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tickets]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tickets](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Row] [int] NOT NULL,
	[Place] [int] NOT NULL,
	[SeanceId] [int] NOT NULL,
	[SaleDate] [datetime] NOT NULL,
	[AccountId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Accounts] ON 

INSERT [dbo].[Accounts] ([Id], [Login], [Email], [IsAdmin], [IsBlocked], [Password], [Salt]) VALUES (10, N'artemmazur', N'artemmazur94@gmail.com', 0, 0, N'pb1jnbMT0kKPm6ae1ZdVnA==', N'vcrSKQKF0TOj4o5+qK875A==')
INSERT [dbo].[Accounts] ([Id], [Login], [Email], [IsAdmin], [IsBlocked], [Password], [Salt]) VALUES (11, N'artemmazur2', N'artemmazur294@gmail.com', 0, 0, N'zHcaSdIFkEIi6cIBiHEjnQ==', N'wz1iENGjZLEu2eCjYz7MYA==')
INSERT [dbo].[Accounts] ([Id], [Login], [Email], [IsAdmin], [IsBlocked], [Password], [Salt]) VALUES (12, N'artemmazur3', N'artemmazur943@gmail.com', 0, 0, N'46ZY7/q1Ap5xq8mXLox+jw==', N'cEdSe3eiFfxS1QttL/XVnw==')
INSERT [dbo].[Accounts] ([Id], [Login], [Email], [IsAdmin], [IsBlocked], [Password], [Salt]) VALUES (64, N'artemmazur4', N'artemm2323azur94@gmail.com', 0, 0, N'6w73YFjDcxJYjq0q2jZGKA==', N'vX8QDdMIjE+VNa6Tm69bcw==')
INSERT [dbo].[Accounts] ([Id], [Login], [Email], [IsAdmin], [IsBlocked], [Password], [Salt]) VALUES (67, N'artemmazur6', N'artem2mazur94@gmail.com', 0, 0, N'HQyGHnwjBz+l+MhfnCN1ZQ==', N'wEy8xCgVNeSyI9RthWM+qg==')
INSERT [dbo].[Accounts] ([Id], [Login], [Email], [IsAdmin], [IsBlocked], [Password], [Salt]) VALUES (69, N'artemmazur5', N'artem2323mazur94@gmail.com', 0, 0, N'VqsRY970pD3KBBt7hA14wg==', N'8bwZ8QiJMB2ORUklpDeaVg==')
SET IDENTITY_INSERT [dbo].[Accounts] OFF
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (1, 1, N'Drama', N'In the context of film, television, and radio, drama describes a genre of narrative fiction (or semi-fiction) intended to be more serious than humorous in tone, focusing on in-depth development of realistic characters who must deal with realistic emotional struggles. A drama is commonly considered the opposite of a comedy, but may also be considered separate from other works of some broad genre, such as a fantasy. To distinguish drama as a genre of fiction from the use of the same word to mean the general storytelling mode of live performance, the word drama is often included as part of a phrase to specify its meaning. For instance, in the sense of a television genre, more common specific terms are a drama show, drama series, or television drama in the United States; dramatic programming in the United Kingdom; or teledrama in Sri Lanka. In the sense of a film genre, the common term is a drama film.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (2, 1, N'Action', N'Action films usually include high energy, big-budget physical stunts and chases, possibly with rescues, battles, fights, escapes, destructive crises (floods, explosions, natural disasters, fires, etc.), non-stop motion, spectacular rhythm and pacing, and adventurous, often two-dimensional ''good-guy'' heroes (or recently, heroines) battling ''bad guys'' - all designed for pure audience escapism.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (5, 1, N'Adventure', N'Adventure films are usually exciting stories, with new experiences or exotic locales, very similar to or often paired with the action film genre. They can include traditional swashbucklers, serialized films, and historical spectacles (similar to the epics film genre), searches or expeditions for lost continents, "jungle" and "desert" epics, treasure hunts, disaster films, or searches for the unknown.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (6, 1, N'Comedy', N'Comedies are light-hearted plots consistently and deliberately designed to amuse and provoke laughter (with one-liners, jokes, etc.) by exaggerating the situation, the language, action, relationships and characters. This section describes various forms of comedy through cinematic history, including slapstick, screwball, spoofs and parodies, romantic comedies, black comedy (dark satirical comedy), and more.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (7, 1, N'Crime & Gangster', N'Crime (gangster) films are developed around the sinister actions of criminals or mobsters, particularly bankrobbers, underworld figures, or ruthless hoodlums who operate outside the law, stealing and murdering their way through life. Criminal and gangster films are often categorized as film noir or detective-mystery films - because of underlying similarities between these cinematic forms. This category includes a description of various ''serial killer'' films.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (8, 1, N'Epics / Historical', N'Epics include costume dramas, historical dramas, war films, medieval romps, or ''period pictures'' that often cover a large expanse of time set against a vast, panoramic backdrop. Epics often share elements of the elaborate adventure films genre. Epics take an historical or imagined event, mythic, legendary, or heroic figure, and add an extravagant setting and lavish costumes, accompanied by grandeur and spectacle, dramatic scope, high production values, and a sweeping musical score. Epics are often a more spectacular, lavish version of a biopic film.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (9, 1, N'Horror', N'Horror films are designed to frighten and to invoke our hidden worst fears, often in a terrifying, shocking finale, while captivating and entertaining us at the same time in a cathartic experience. Horror films feature a wide range of styles, from the earliest silent Nosferatu classic, to today''s CGI monsters and deranged humans. They are often combined with science fiction when the menace or monster is related to a corruption of technology, or when Earth is threatened by aliens. The fantasy and supernatural film genres are not usually synonymous with the horror genre.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (10, 1, N'Musicals / Dance', N'Musical/dance films are cinematic forms that emphasize full-scale scores or song and dance routines in a significant way (usually with a musical or dance performance integrated as part of the film narrative), or they are films that are centered on combinations of music, dance, song or choreography.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (11, 1, N'Science fiction', N'Sci-fi films are often quasi-scientific, visionary and imaginative - complete with heroes, aliens, distant planets, impossible quests, improbable settings, fantastic places, great dark and shadowy villains, futuristic technology, unknown and unknowable forces, and extraordinary monsters (''things or creatures from space''), either created by mad scientists or by nuclear havoc. They are sometimes an offshoot of fantasy films (or superhero films), or they share some similarities with action/adventure films.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (12, 1, N'War', N'War (and anti-war) films acknowledge the horror and heartbreak of war, letting the actual combat fighting (against nations or humankind) on land, sea, or in the air provide the primary plot or background for the action of the film. War films are often paired with other genres, such as action, adventure, drama, romance, comedy (black), suspense, and even epics and westerns, and they often take a denunciatory approach toward warfare.')
INSERT [dbo].[GenreLocalization] ([GenreId], [LanguageId], [Name], [Description]) VALUES (13, 1, N'Western', N'Westerns are the major defining genre of the American film industry - a eulogy to the early days of the expansive American frontier. They are one of the oldest, most enduring genres with very recognizable plots, elements, and characters (six-guns, horses, dusty towns and trails, cowboys, Indians, etc.).')
SET IDENTITY_INSERT [dbo].[Genres] ON 

INSERT [dbo].[Genres] ([Id]) VALUES (1)
INSERT [dbo].[Genres] ([Id]) VALUES (2)
INSERT [dbo].[Genres] ([Id]) VALUES (5)
INSERT [dbo].[Genres] ([Id]) VALUES (6)
INSERT [dbo].[Genres] ([Id]) VALUES (7)
INSERT [dbo].[Genres] ([Id]) VALUES (8)
INSERT [dbo].[Genres] ([Id]) VALUES (9)
INSERT [dbo].[Genres] ([Id]) VALUES (10)
INSERT [dbo].[Genres] ([Id]) VALUES (11)
INSERT [dbo].[Genres] ([Id]) VALUES (12)
INSERT [dbo].[Genres] ([Id]) VALUES (13)
SET IDENTITY_INSERT [dbo].[Genres] OFF
SET IDENTITY_INSERT [dbo].[Halls] ON 

INSERT [dbo].[Halls] ([Id], [Name], [HallPicture]) VALUES (1, N'Green', NULL)
INSERT [dbo].[Halls] ([Id], [Name], [HallPicture]) VALUES (2, N'Red', NULL)
SET IDENTITY_INSERT [dbo].[Halls] OFF
SET IDENTITY_INSERT [dbo].[Languages] ON 

INSERT [dbo].[Languages] ([Id], [LanguageCode]) VALUES (1, N'EN')
INSERT [dbo].[Languages] ([Id], [LanguageCode]) VALUES (2, N'RU')
INSERT [dbo].[Languages] ([Id], [LanguageCode]) VALUES (3, N'UK')
SET IDENTITY_INSERT [dbo].[Languages] OFF
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (6, 1, N'The Godfather', N'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (11, 1, N'q', N'q')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (14, 1, N'new', N'new')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (15, 1, N'new movie 2', N'new description')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (16, 1, N'moi film', N'moyo opisanie')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (17, 1, N't', N't')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (18, 1, N'm', N'm')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (19, 1, N'o', N'o')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (20, 1, N'5', N'5')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (21, 1, N'xomne', N'some')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (22, 1, N'my movie', N'my description')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (23, 1, N'some movie', N'no genre while adding')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (24, 1, N'Troy', N'An adaptation of Homer''s great epic, the film follows the assault on Troy by the united Greek forces and chronicles the fates of the men involved.')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (25, 1, N'The Great Gatsby', N'A writer and wall street trader, Nick, finds himself drawn to the past and lifestyle of his millionaire neighbor, Jay Gatsby.')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (26, 1, N'new movie', N'new description')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (27, 1, N'my new movie', N'my new desc')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (28, 1, N't', N'dfg')
INSERT [dbo].[MovieLocalization] ([MovieId], [LanguageId], [Name], [Description]) VALUES (29, 1, N'smth', N'smth desc')
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (6, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (6, 9)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (6, 10)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (6, 11)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (11, 2)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (11, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (14, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (15, 2)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (15, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (16, 2)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (16, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (17, 2)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (17, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (19, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (24, 11)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (24, 12)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (25, 14)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (25, 15)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (26, 4)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (26, 9)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (26, 11)
INSERT [dbo].[MoviePersonsJunction] ([MovieId], [PersonId]) VALUES (27, 10)
SET IDENTITY_INSERT [dbo].[Movies] ON 

INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (6, 175, 1, CAST(N'1972-03-15 00:00:00.000' AS DateTime), 2, 10, N'https://www.youtube.com/embed/sY1S34973zA?rel=0', 0, NULL)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (11, 4, 1, CAST(N'2016-02-20 00:00:00.000' AS DateTime), 2, 20, NULL, 1, 10)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (14, 4, 1, CAST(N'2016-02-05 00:00:00.000' AS DateTime), 2, 23, NULL, 1, 10)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (15, 187, 1, CAST(N'2016-02-20 00:00:00.000' AS DateTime), 4, 31, NULL, 1, 10)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (16, 100, 1, CAST(N'2016-03-04 00:00:00.000' AS DateTime), 2, 26, N'https://www.youtube.com/embed/3Kze_J_BtxY?rel=0', 1, 10)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (17, 2, 2, CAST(N'1999-10-10 00:00:00.000' AS DateTime), 4, 37, NULL, 1, 10)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (18, 1, 1, CAST(N'2011-01-01 00:00:00.000' AS DateTime), NULL, 39, NULL, 1, 10)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (19, 1, 1, CAST(N'2001-01-01 00:00:00.000' AS DateTime), NULL, 40, NULL, 1, 10)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (20, 5, 1, CAST(N'2001-01-01 00:00:00.000' AS DateTime), NULL, 41, NULL, 1, 10)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (21, 100, 1, CAST(N'2000-02-02 00:00:00.000' AS DateTime), NULL, 42, NULL, 1, 10)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (22, 15, NULL, CAST(N'1999-01-01 00:00:00.000' AS DateTime), NULL, NULL, NULL, 1, 10)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (23, 30, NULL, CAST(N'1956-12-01 00:00:00.000' AS DateTime), NULL, NULL, NULL, 1, 10)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (24, 162, 8, CAST(N'2004-05-14 00:00:00.000' AS DateTime), 10, 53, N'https://www.youtube.com/embed/Voai-4GS848', 0, NULL)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (25, 142, 1, CAST(N'2013-05-01 00:00:00.000' AS DateTime), 13, 54, N'https://www.youtube.com/embed/sN183rJltNM', 0, NULL)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (26, 4, 9, CAST(N'1900-01-01 00:00:00.000' AS DateTime), 11, 56, NULL, 1, 10)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (27, 140, 6, CAST(N'1999-01-01 00:00:00.000' AS DateTime), 9, NULL, NULL, 1, 10)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (28, 5, NULL, CAST(N'2012-12-12 00:00:00.000' AS DateTime), NULL, NULL, NULL, 1, 10)
INSERT [dbo].[Movies] ([Id], [Length], [GenreId], [ReleaseDate], [DirectorId], [PhotoId], [VideoLink], [IsDeleted], [RemoveExecutorId]) VALUES (29, 30, NULL, CAST(N'2011-12-12 00:00:00.000' AS DateTime), NULL, NULL, NULL, 1, 11)
SET IDENTITY_INSERT [dbo].[Movies] OFF
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (2, 1, N'Francis Ford Coppola')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (4, 1, N'Marlon Brando')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (9, 1, N'Al Pacino')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (10, 1, N'Wolfgang Petersen')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (11, 1, N'Brad Pitt')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (12, 1, N'Eric Bana')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (13, 1, N'Baz Luhrmann')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (14, 1, N'Leonardo DiCaprio')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (15, 1, N'Tobey Maguire')
INSERT [dbo].[PersonLocalization] ([PersonId], [LanguageId], [Name]) VALUES (17, 1, N'Carey Mulligan')
SET IDENTITY_INSERT [dbo].[Persons] ON 

INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (2, 43)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (4, 44)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (9, 45)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (10, 46)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (11, 47)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (12, 48)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (13, 49)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (14, 50)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (15, 51)
INSERT [dbo].[Persons] ([Id], [PhotoId]) VALUES (17, 55)
SET IDENTITY_INSERT [dbo].[Persons] OFF
SET IDENTITY_INSERT [dbo].[Photos] ON 

INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (10, N'/uploadFiles/800fc71c-c4a7-4876-976f-159f740d4a28.jpg', N'800fc71c-c4a7-4876-976f-159f740d4a28', N'1972.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (20, N'/uploadFiles/6fd0e4c4-2a47-4580-8ffa-ceae371112f3.jpg', N'6fd0e4c4-2a47-4580-8ffa-ceae371112f3', N'Nikon-D810-Image-Sample-6.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (23, N'/uploadFiles/461d8c17-60ec-4c64-aec2-9e5047dcfe11.jpg', N'461d8c17-60ec-4c64-aec2-9e5047dcfe11', N'Nikon-D810-Image-Sample-6.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (26, N'/uploadFiles/c8100cc3-74fe-481e-81df-dc674b2669d4.jpg', N'c8100cc3-74fe-481e-81df-dc674b2669d4', N'southtyrol350698.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (31, N'/uploadFiles/f4e8cfdf-5ad2-4097-91fd-e46173f1fe04.jpg', N'f4e8cfdf-5ad2-4097-91fd-e46173f1fe04', N'southtyrol350698.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (37, N'/uploadFiles/f8468870-c363-40b1-90fe-20764f880a13.jpg', N'f8468870-c363-40b1-90fe-20764f880a13', N'Nikon-D810-Image-Sample-6.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (39, N'/uploadFiles/a00fea49-df78-4102-9c5f-8e6a0d944f3e.jpg', N'a00fea49-df78-4102-9c5f-8e6a0d944f3e', N'Robert_Downey_Jr_2014_Comic_Con_(cropped).jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (40, N'/uploadFiles/9629ccd8-9eae-4f91-bb8d-d20625d376da.jpg', N'9629ccd8-9eae-4f91-bb8d-d20625d376da', N'49e23d74c5bd677f_robertdowneyjr.xxxlarge_2.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (41, N'/uploadFiles/7c5ab7c4-f3bf-4991-b2e0-2e65596d0962.jpg', N'7c5ab7c4-f3bf-4991-b2e0-2e65596d0962', N'49e23d74c5bd677f_robertdowneyjr.xxxlarge_2.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (42, N'/uploadFiles/9bb45a2b-a50b-4ed4-827d-a991508b6e30.jpg', N'9bb45a2b-a50b-4ed4-827d-a991508b6e30', N'southtyrol350698.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (43, N'/uploadFiles/ca68b3d1-5de6-49af-bfd1-b29d5111cd90.jpg', N'ca68b3d1-5de6-49af-bfd1-b29d5111cd90', N'Francis-Ford-Coppola.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (44, N'/uploadFiles/35a70029-35c3-46ec-8177-d35a55d273e8.jpg', N'35a70029-35c3-46ec-8177-d35a55d273e8', N'Marlon_Brando.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (45, N'/uploadFiles/22b48771-23d8-4347-8b05-3cc7de8f5209.jpg', N'22b48771-23d8-4347-8b05-3cc7de8f5209', N'220px-Al_Pacino.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (46, N'/uploadFiles/52c3e8cf-6d23-471b-8781-055648295e12.jpg', N'52c3e8cf-6d23-471b-8781-055648295e12', N'Wolfgang_Petersen.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (47, N'/uploadFiles/44b8a4f7-fda7-41b8-9c04-ba92456ea5e1.jpg', N'44b8a4f7-fda7-41b8-9c04-ba92456ea5e1', N'Brad-Pitt.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (48, N'/uploadFiles/a965d315-3c4c-41d4-9415-01f153c43565.jpg', N'a965d315-3c4c-41d4-9415-01f153c43565', N'Eric_Bana_2014_WonderCon_(cropped).jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (49, N'/uploadFiles/b325cdb1-b811-4147-a100-b100429f28ac.jpg', N'b325cdb1-b811-4147-a100-b100429f28ac', N'220px-Baz_Luhrmann.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (50, N'/uploadFiles/78778e14-b93a-493d-a254-9ae0f119158f.jpg', N'78778e14-b93a-493d-a254-9ae0f119158f', N'422817_original-jpg.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (51, N'/uploadFiles/e076eedf-4f48-46c8-b0e2-6ad8a49d09c7.jpg', N'e076eedf-4f48-46c8-b0e2-6ad8a49d09c7', N'Tobey_Maguire_2014.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (53, N'/uploadFiles/7a310bf5-a8aa-4eef-b954-daca0f2064b9.jpg', N'7a310bf5-a8aa-4eef-b954-daca0f2064b9', N'defa55086d1d29228b0290b71a07486d.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (54, N'/uploadFiles/453cb555-77ee-4275-a772-313d76c6c57a.jpg', N'453cb555-77ee-4275-a772-313d76c6c57a', N'a-great-gatsby.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (55, N'/uploadFiles/72535d5c-efab-403d-a90e-f2479cc860bc.jpg', N'72535d5c-efab-403d-a90e-f2479cc860bc', N'carey-mulligan-435.jpg')
INSERT [dbo].[Photos] ([Id], [Path], [GUID], [Filename]) VALUES (56, N'/uploadFiles/c04eb1c4-583f-4d9a-84bd-13ee6c75d817.jpg', N'c04eb1c4-583f-4d9a-84bd-13ee6c75d817', N'images.jpg')
SET IDENTITY_INSERT [dbo].[Photos] OFF
SET IDENTITY_INSERT [dbo].[Profiles] ON 

INSERT [dbo].[Profiles] ([Id], [Name], [Surname], [Phone], [ImageData], [AccountId]) VALUES (1, N'Artem', N'Mazur', N'8888888888', 0xFFD8FFE1001845786966000049492A00080000000000000000000000FFEC00114475636B79000100040000003C0000FFE10369687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F003C3F787061636B657420626567696E3D22EFBBBF222069643D2257354D304D7043656869487A7265537A4E54637A6B633964223F3E203C783A786D706D65746120786D6C6E733A783D2261646F62653A6E733A6D6574612F2220783A786D70746B3D2241646F626520584D5020436F726520352E302D633036302036312E3133343737372C20323031302F30322F31322D31373A33323A30302020202020202020223E203C7264663A52444620786D6C6E733A7264663D22687474703A2F2F7777772E77332E6F72672F313939392F30322F32322D7264662D73796E7461782D6E7323223E203C7264663A4465736372697074696F6E207264663A61626F75743D222220786D6C6E733A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F6D6D2F2220786D6C6E733A73745265663D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F73547970652F5265736F75726365526566232220786D6C6E733A786D703D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F2220786D704D4D3A4F726967696E616C446F63756D656E7449443D22757569643A37433337333138323838303531314445413338313932423341363944463344332220786D704D4D3A446F63756D656E7449443D22786D702E6469643A44414635443042434146433631314446393945344544433433453734324345382220786D704D4D3A496E7374616E636549443D22786D702E6969643A44414635443042424146433631314446393945344544433433453734324345382220786D703A43726561746F72546F6F6C3D2241646F62652050686F746F73686F7020435334204D6163696E746F7368223E203C786D704D4D3A4465726976656446726F6D2073745265663A696E7374616E636549443D22786D702E6969643A4438373530323544323032313131363841334331423338363837434332323835222073745265663A646F63756D656E7449443D22757569643A3743333733313832383830353131444541333831393242334136394446334433222F3E203C2F7264663A4465736372697074696F6E3E203C2F7264663A5244463E203C2F783A786D706D6574613E203C3F787061636B657420656E643D2272223F3EFFEE000E41646F62650064C000000001FFDB0084000604040405040605050609060506090B080606080B0C0A0A0B0A0A0C100C0C0C0C0C0C100C0E0F100F0E0C1313141413131C1B1B1B1C1F1F1F1F1F1F1F1F1F1F010707070D0C0D181010181A1511151A1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1FFFC00011080145010403011100021101031101FFC400850000010501010100000000000000000000050102030406000708010100000000000000000000000000000000100001030302030505050506050305010001110203002104311241510561712213068191321407A1B1C14215F0D1522333E1F1627282164324342517B25326A26373834408110100000000000000000000000000000000FFDA000C03010002110311003F00DB21E6A940ACBF70FB2817712081412C41C0AAFB2802C81A72A5375323947B6808C5B8C7702E14DA81B9206D01050561F0B7B0DC73A079DDC3DF411C8017ADC12AAA283A12BFE5B2505824EC288868017564697A9B696BA93418C0F964EAD930E3BDB09746D0E9480E401E7EFA0D747D0F37A844C3D5739B938ED2D631BE435AEDAD08D47AEE5EDA01DD7F0D9D0190CECC8964C391E7CD32147345906E074EFA091FF54FD1DD29A22932DD3CBB7C4D81A6400A0B17582D00FC9FADFE9773C362C7C991AEB39DB5AD4F6137A0BFD33EA57A533DC19F34719F701B3B4B015D10DC506C7A5E5636442C9209192B35DCC70758F750130A87D94114BA225FB682A4A4682C4A1BF2A074446D2389B28A0B517C20F31C6807F5E6A74ACC2A0244F5B7F84D077A7DADFD2F053842C03DD40718801E7410CFB3768A8541A0A39843227ED1E142B400A3C764D9B146F3B44643C0088E714B13CA835C268E08591E1B03370779CD1E26EDBD81EFA0CFFC9C1F35BF71F375DBF9555282E2855A0516B8EE140AD3AA7BE827853701AF1A006D7033B892BE3728FF005501360262D34E3EDA06CE0796D2E0838EB415D0060BAF2A07684FEDAD0444AC8D00AAEB40AC0428096D128260E262249B5001EA4FF14A84870D08D2F41858B260C2EAD999724AD6C30B5BB8B871739D7A07FA9BEB5B190458BD1602F7C2CBE54A89BB9060170283CCFAD7A9FAEF5A9DD3F52CB74A5DFF000D5183B0345A80617ABCB45FF0141CD2E0F20104F04D2815F24AC25BA11C415A0BFD2FD4BD6BA64ED97032A581E2E76145EF1A1A0F44F4DFD78EAD048D8BADC4DCA82DBA58C6C9401DD6341EAFD03D63D03D458FE6F4CC8DEF6B773E07F86568ED6D05C91C7437274E1412E38F08542A6E6F41618401CCF0A0A9EA0C4649E9ECF94CA06D81E5CC0112D6B9A04F4FB53A6E26E08444C6FD9406D9A905395055C9680A555C341A6B403B35CE38FB631E1252FDFAD00E6CA5D93230351CDF036C9623B680F6346E6C001F16D6D89BD870A015B7FEE5BD6FAA70D682D8DA9D941C2DDC681C2D6E5AF2A09E1F8F99A00311FE61714F89D71D8680A37FA2B70A1428EDA06CE5A803949EEE341010084758711408E706B5C375E822681E68D4926C4504AD6DDC469C12815EE0D891168323EADEB785D1B0E6932E6226DAB1401A373DEEF846B617D683C2FAD75ACEEA390F7BC86316D1B6C00171DF403839C11575BD035FDDEDE540E64614711C791A0730381F00B8ECFDF408439C85CB7BEB7A047B485734953A2F1A06A166AED6E0D05AC0EAB9B83911E562CEF832233E09633B48F7507AFF00A27EB1B72CC7D3FD4243263E1873DA11AE3A0F3070EF141EAD8EEDD08702A1DF0B9751CC50588CB80D17B4D00DF51B1EFE859EE4F088DC5C9EEBD05DE8D181838AB77794CFBA80B35368078D056CA432105B602D402BA882714B1A40B20ECA01F14A5F2BCC8747351DCD1A025069232D10A27E5B9A005B3FEE1B6FBB55F6E9DD417BF3507016D681CDB1B95E341343A870BF6D001840045D2E49EE2680A33FA42CE25281AF69F0AAA134113D4800E8BA9140C72069ED37A08210AE5E3CD787650480B48E4A5138AD00AF567A9B13D3FD2E4CBC804C855B0443573D2C283E7EF51FA83A875BEA32E6E53CB9EFD1BF95A1111A380A0121A0E9DDDB40819AA0BD04CC883DA36A271239D04F8B8524EF11C6C2405426808627A772F7B778686BFF00313CA82577A71DE6A4AF058A40017F0A089FE9E735C4976D1C1D72A2829CFD11EC72C68E04F8781A081DD3266F0B05257DE81282B80F6381D50043A507ADFD29FA872433C5D07A9C9BA09486614C6E58F360C24FE5341ED22C16E7B68047AA32447D0B39802974443F822E9A71A02BD25A1B8706A823658FF9450136A16837A0A595A901C6D6A015D45CD10917253F60B403F053CE2DB239DA735E541A60BB0800DB85067FC7FABEC4F122FB37501020D934D2F40E006BFB0A070ECD28258F43A581FBA833F8E14826CBA50156AED084A22D07481A1A0AA27DB6A08C68179DC50432B92C06ABDD4114680017F650383831AE7BC80C6AB9CE3A0035A0F04FA87EAE3EA0EB67CA0987884B318FF10E2E3EDA0CAB033C45E482961C492682C63E149283E5B0A25F822505FC6E8B19717CCE240B6C50280943878915A28C006DE242682C3311CE76E8EC1B6416FBA82663676B8F668355A0B5116007730877F11BAD055CD64A5A2C761E3403278BC3A95A081790ECF6D038438D280D91A09D0A5B4A08E7E8B26339991864F84EE0850822E08E341EFDF4FBAFC9EA1F4BE3E448F03271C7939AE3F95EDD11BC4B8504DEAC880F4FE506BB6B5A017B9D72E2E2001DA4D01FE98171A22742C6803D8280878762277D050CA45453E24012806F5123C92D22DCBBA82A74B23CF5B217201DB41A00518425C6BC28007F33F5A5E1B57D8B40401520F02B40F046897140AD55E3D8282660218FE684FD9419FC42AC6EA97A028D27CB6A0E0174A0499C4968D001A50464129DEBC3950579080081AA14D6813739AC5501468874A0CCFD47EAD274FF00486516BC324C82208D353BF5FB283C0C355C01F17202D7EFA021D370A39C9DE4F813C360280C9632156C7C751411891CE3AA29BDAF41771446D70333B685E4B6E69405B0A699ED0CC4C332389BBF536D12D40719E9FEBD27F3061B6F70E28BFB0A07CDD23AA490B587098CD82E402A7B6D403B37A6E736070F2ADC88B8ED140266E9B95B1DBE0467F15003C9C3998A4F3E1A8A0AEC3B4A1FEDA0358E416053C0120EB404BD03EA3C9E83EA99305A8DC1EA8E6B124366C84F81FEF28683D5FD505F8FE9F9E0710F7388324845CB8BC68795068BA78FF966145568D7BA82E84D82DAF04A01B96438EA6E52D6D280775070318055550FB682BF4963BCE500068255385D0501FB08D38F05E5419BDEEFD77CB51E66CDC97D375015F0F0140A178E8795039A2FAF7504A4910CA4E818EEFD2801628688E3D5CEE4744A0244911828DE1FB1A06CBE220E9DDDB40C7346E681C282B4B675C29768941D335ED0D0137259683CBBEB3E62BBA760823C21F3B80EFDA3F1A0F33631E413C0A58D89EEA03D83018606D86E2140FDF40E9654502E7F1A08D90BDC7739C422AF7D012C3F978DAD25AE7BCD8F2FB68361D1B3739807CB62343555BBB5BF05E541A9C2CCF53F961DB636B19A37FBF54A09DD91D6769778547E53A1A0079B36439C4BBC2E695704A00B9D34A850EE68B0B1A0CD67BC80742A1178AD003793BC5BB680974F90BAC75BA1A0EEB78EE10B666BB6C919DCD7F11EDA0F558BD42DEB5E87C3C9701E73DAC6CA02121EC7B5AF7BD3453F0D07A06082206EE21368FB8505B3F01437E0B40372B799006B86DE3402BA9B9858D687713A73A04E8E0688A7553DFC680DBBE02501A0CBEF3FEE0542BB1138FC5406CA2D070005B971A07B4DF91A07C84FCB4DD8C77DC6801E383B5AA0DC0A026090C0D40840E540C989516FEEA08E5F89A808ECA080217A71A049CACDB54237873A0F0EFA93952667ABB2626DD98FB6089A74040D07B4D006C6C2936012B7E12802F0EE1AD016D8D3A5AC817F1140C1002E57D82D8D04AC882028AE2554D05CC6F0C81CEF11FCA9A0A0D074ECECA678618C29215CED13D941A0C7CDEB0406B4B141456A93EFA0BD14F945ED131B9E1A50439F8A5CD54241297A0039D8EE6A0682EB2122C68337D47A6CBA86F893DB401E5C1983976F695A0B188C7B480E6D872EDA0B7998CC9A27C4E162D404D0683E9E48E6FA33AAE33FC220CE8909E4E2DB7BC507B4E1922162FF00084A099CEDCCF0141CCD00CC8DDE706836174ECA013D4880F6B55105FDB412F486FF002F75C9514069CDFE5AD978D065378FD7150F244E1A2D01D1C6C940E6A00A75D02E9AD02B6FA5A81F28FF00949CEAB1BADECA00B0208DAD1F0900A9B22501201A436E5282391A43947DB4114A5D60BCD6822008702BDFECA0864241748002E009DC7B2E1683E75EA72CD93D572F3253B6574CE794BA38B8D05FE9D8B31689267173D2F7B0A020D0DD75737DD4081AE99D6B93DBC076502CBD4307080F3DE3713668B900F3140D87AD3DCE127903C8BF96E25D74E7B41BADA8347D1BD54F6B621174D7995C50F9A431A1A9F11A0D761756CE9182776346C06CE637876D0178D91CFE5C9B401AB76AA1F6D024AD32BBCA6025A352135D68076461A4A4B9880283DFCE8004D2C5219D8E6001A5C1AB63E1FC28323D4FD418503F6BA0700540936F84EDB14A00AEF5518E525B10D9AEE3A11ECA02381EA5C1EA0E6449E54FA29F85C134A0D0FA3B293F57C5546493E33B9850683DDA14F2C03AA0B0EEA07BD00B69402E772E428704BFBA80467A39E0AA20D46B6A0B7D24781ADDA7505A7BC50179006C46DC3EDA0C779B27FB8D6FB3CBDFB138E941A4DD61D941DDA681CD04F68A0925FF00A498FF0081DF750068C80C0D23C48084E5417DAE08DB154B50248771BAA14B5041229700A142D042FF000BC3950A215FDD4114A0BA39838297308BE9F0945A0F9D445237224748F6C65A4E9752BA501BC06938EC711B1CFD12E9CA826F26DB07889F6276D0365C818CC3142D2FCA90231A971DB4177A17A4269E512E435B24A483248E2480BCB5D28368EF4774463639430B258D6F1B8804F1502D40E189818CC2D68F091B5C480AE5E652F412C32E3B623146EDAD75C1078FB6809606608C35BB94017E54165F951B0EE0CDBBB914BD00FCEEA6D734B41469041A0C765CB8D1BA56BA456BCF1FE1D4FBE8047CA63643EED2E436DC11A8BA0A0B4DF4CF44D8D7BD8D73D755B7725005EADE978635C8C3292C65431A1015A0B1E8BCA907509637D9F2491B8B79969A0FA37026DF134AAD8504F2A9052FD9402A6DC72111AD621B71A0119E4991C5A96041A0BDD25AE11C5E2BEE5212FA250159BC3095A0C7A1FF0074AAFF002FCAD56CB41A30E69D386BEDA0508B40E0508E54124CBF2731E1E5BBEEA011093E483FC67EEA0B8D202702962681AF75F976FB6818E6ABBB36DE820730B9ED235E24F6D045244E90C8C20A3DBB4B814D45A83E7BEA586EC6CF931A461324733D8178B5AE372280C74805D0154505001C050106C0092494E7412F43E92D766CB9929DCE2488D492805A834C7AAC3880004300D6803753F5CC10C8F884AC85E0286BD4B9E7800071EFA0CF45EB4CACECD7E3C5338C6D277485A036DC4AA2501AC7932E5607AEE50A1CCB020F114047A7F50CA8650D955C399A0D43C19304CBC1168303D5FAB643A73063D80284DD6823C4E8B91302E99FE5B1A37CF932290C6F60E24D009EBDD40E2C9938BD2FA74F2CF88D64F3E4E507A88D42BBCB6A0632E3E2E740270727D5797D372BAA63421D878B20F9A309F1460B75DA7876D014E8FD746586B5D20713E114098F13B1FD650152237B4BC3468787DF41EFBE9ACD1363343B540BDF407A54F2CA69401DEE3E6B82A340E6BC74A0119E52490D934B9A031D35A598D138D94924FDD40426FE9381D4DC7B68319E1FF76A2F8366D4F66941A02BCEFC281E1CE55E4528246BF8F0E06825C8FF00A0C80A3E03F6D00A62F94CB01C0A505C6EA15D73C6818F2AE3C50DA81AEDDB93B28217ED06DA9D68228DC1D21286E973C80A0F2DFA9FD18E3F5E8FA842764796C6822E9BC58FBE802F4205C656B92CEDBBB85B9501B2CF2DA3B6C4D02C192F8C96801BC001A25007EA27A9E775387030FC39133832391C51B1826EF24DA80BFD46FA6B8FD13A4F4ACDC3C6933446E27AB6505323DC50AF1DADD5395041F4A3A21EA7EB59B3F1304E3741899209F1E7591BE5BDA9B1CE7001D7BD06A327A4E074AEA9347853473F4F0F1B71C157441D721A428701F6504DD6E3C13931B31A2D8D6B15F755274A0B1166EDC174202D9128313343E5F52DEF0ACDCAEEC1C4D06C7A6A6675383372318CDD2F11E0C18B1398D8DC5A1048E5BB9DBB81B5005FAA3E9DC1EB19FF00AAE0CF2F4FCCC88F6E742E697C6E637897C45C38684500FE8F9DE99F4E7A726E958323FA9F52CC76FC93B0B6305136F8AE401419FC6F4C08330E4C71ECF3097A36CD6971540DE54047AAC51E1E474DCD9858BCC0E29C5F767DB41E99E90CD2BB0BED6048EEA0DBB9C0C25CBC280390449212805894A0179CC697BD10346D41DF40770584431803E1556D05A9806C7E2E084F21418D56FF00BB375B6AA767F4D6834A5AB721072A050DD09BAE846B40E6DC2917A0932CFF00DBB22DF912806B0344318E3F850596016B85A0638124700BAD071F8BB0EB4159C2EE5BDE8327EA8F52E574F9DB8D8F332090A12E91154F06EEB5065FD55D67A9F50C3C58F2F63CC4E73D990C6A3882111C34A013D031A58FCC2F3675C0283EEA03136EF39A1141B77505A8F05B24AD1C3F3505A93D3F0644BBD9D9DE08E541A0E8F0F5EC76083E726763B94797B9422582396D417337A5E5490EC7BB6C46FB4B8A1B27C0DDADFB282B331D9818EE3081BB40506B402CC6D05D2BCAB8AA9A056B9A1A5C4A84A00F9A231239C459C0FB283BD35D60E0E63F19C0BB1A42AE6F23FC42834B9D898B951EE00398E5522CE43DDF8D06767E8D8F03CB98D40B6E0795023630C09C57D940CF50E245374B8DD259B1CD1BC7639535F6D0683D1C5C646DB5361C2D6A0F417126120DDA75A018493BC223070E26806E56F748F5084BD809EE341A0C66BC46C0802F2BDE825C84F2DCA1568317E73FFDD09B7F97E7F97ECF975A0D55FDF41CD4DD6374D7FB281ED5E3A1D1281F9A53A7CFCF68B7B4500B637F96C3C48BA5ED41640E4468BA0A047214E25795034B51E42D042E05A49E2BA70A0C3FACBA2E1F52C894E544D9626AA822E0B235B1D78D062DB8F3E0E13586474B8251A19295731C4D834F114043A743B6C070F7505D2C3BC73E5404F05BB8E9C87BA8341D37164738580E5CA80FC11470A171B81C282BCA5D95216B416C6D372680575E2D6011B6C8113F1A0CFE4CE4BD9137E27024F70A058DB92E2D8DA091FC5411E774BCA2D7392FFBE800B5B263CCC6B9A7735CAD7730BA5069F0E67ECDCD3E12853BE81728EF700D06E6E7B28053B277B9EC0D20B0A762D00FF54E76CF4B649FCD118DC0F7482835DE831E6C304A6DB9A08F68141E8330031CDCDF54A0172B097B8E9C8F6D00B2E71C802E865174B5A834D8ED0D6B49B6EB95BD049948E84A9B731634184DF27EBDE670FD47CB5ECF97A0D81F86D6A0500EDB1B9D281CD4171FDF40BD45BFF6C9BB40D3BC500D6598C4544E3AEB41680280A2A8ECA0691E2052C3BA81AE284A0BA71A089CD37E37F75065BD551F971CD202A1EDB1EC734B7F0A012CE858F2E345E7B7CC6B9AA87828D4500BF224C590B4A80D03693C5A743F650597B0860901B382FB682E74F7B40DC48DA74341AEE8F3B365D0F02BC280C7CBC320DCC6A8E40A7F750749B2266D680D1C28339EA881F062BA770DD24882307B680174DE9B91349E6CE493A03C86B41A8E8D91D1F18B9F95019CA230028011CE829F56EA98B248FF002C358DFE11A506732628E66BA560050AA9A0BB144D18D1C8C0AC3A273A08E49DC1C5B7E5FBE805E61424B01F19B8B50657D6B9059E9C9D84DE69228DA071F12FE141E85E82CD8841042480E6B1A0703A0D683D16797763100AF67B6806EC217F2DEC154EB403834BB398746EF50782D0699A020DC3C29E13DB40B901622AE4EDA0C3AB3E6753B7F58DBBB8A79288B41AF2A500FB6F40B7E1A70A05684402C96341DD48A74D979787EF1403A376F6B1C1AE0C4DAA42024725A0B7B4ADD741C681BF771A0690373A82372808745A009EABC6F98C2F0A0DCAD1F785F6B682B617A83A7E2E3E36E83CD3E518DE0354FC2850731419093ABBF3607367C77636462BBCB0A2CF8D7C2E06826C67F9988E6950971EFA0740EDAE0D68EF5D28343D2F201795722A041C6835506537604B134136306CD92F2FFF0084035BED0A68007AEE6646EC07BCFF00243DC1EE170086F8450664F55F54666F87A0E04031A2F0BFA86749E5C6BC98C1E37FBA82069F5CB637B323A7473001464623D59ED6BBC42833FD50FAC618560C20D7484AE44AE1B07FA7E229410C6FEA3D330FE6B27D4116638DE4E9E2242A7831C3F7506A3D1D9B9F95D2A6933E238E2598BB1639023C47B40523829A0B3945AAEE6795008C992C40E1634197F57163A3C0C79012C93237392E9B45BEFA03FE92CD31F526B5C2E00FB4D07AFB66DD88D21A4E86DCE82073CB95C011B5517F75051C068767B4A7C25C483EFA0D346402D46E838DEE681725BBA2B845E3A5060F778BCDF2CAFEB9B578226D5F7D06D381E7CE8102284140E04A9B91410F597B63E932B9F70ADB712542500DC799D902295A2401DE16C4F45DC78045A0226373660C791B8057341500F25A0671370BDF40DB2B81BF75023434B8037056DDB410F54C76CD8B2C4501D438F04D34A0C6331B665B8B5BB246AEE1C01E245055EA989264C39392D07740CDC48B0241BD00BE99317AB40058BE0F7504D13A36CE5A7537A0338728686A04A03F87928C17576A94053032618DAF7C850F2B2760A015D732F0B2B19F89346266BCA90740798238D06561C48F0C96C7248E6EBB1CE5681407BA6F52FE46D1E1768E3D9414BD42F964C5297B6A6F4190C59A26CAAE037B7E1701717E74055D9B2B9A81CA7BE8164CB73F69704289EDA0A3391BD45C937A0CD7A9A0CC7E743344C74ECC484CB2C6DD76EEBBBD9413FA5730CBD4639D87F94F4008D15743DA283DC706471C0079007BD681267B830BC946952471ECA0A9D31E1B9AF91E0B83038A68A6D41A7542072454E140992D2E8C107B8D060AFF0023BFF2FEB69B7FFDA8AB41B7FBC50357DA7950398964F71A0A7EA5DDFA1646D0093B7C2742A5385009E87839B891B67CA95C7236F96C01D66B3950140259A50C894075820F113EDA0227D3EF107826DB917207E5EEE7403164648E832186399B62381EE3C681F1A79817FBA81D246763D4845245079DFAE3AD0E839032A4639F0B95AE2CD47B2831BD6FEAEE31E932E174C85C65986D748F1B5A17B353404BA1B97171A60A4CB1B4DBFC414D05BCA6480AB02B8154F6E9404A1C8DF1B069CCD01287291A80DC71A0B6ECF2E60635D73ECE1414E49DAD25CE234D280364656465CFE562B3CC428F7FE51DF407B0FD25953634729CFF002657FC2D02C08E6414A0A3D4FD39D571E4114F9E3218EBED61B7E1419CCBE8D3C277C4F1BDDF90D0561933B260D7B48FE2A0BF1C9E6B3703A5044BB9C835D1681DD0246C9EABCD8ECE6C58C18F04E82CBF7D0332BD353F4DEBA7A974EC7DFD2E4DA737163558DDC6563790E341EA1D365FF92601E26B9836B9A781E22827983844D79B784F87F0A05F4EE38C8CC99C5C58F6B4794DFF0052A9EC1406B1BA745890B237C921DA55A3C3B9C49DC5C495D5C78503F3034C650A1E0754A0C4DBF425DA53F55DCB645F9AA0D711709EFA0420AD02B05F4A087AC063BA63C3EEDDCDDCBDEB7F750078279A67FF0031001FD38C5D19FBCD06ABA2E340D8BCFF008E77047388236A7E50B40453FBE828F54E9ADCE80B43BCA9DB78A601483C8F31419EC4797BCC3334B7222716CCC3C08D08EC34169CD8DD190846E286FC8F0A0C17D53E9ADCAE9522355C1AE213B283E72902388E56A0F5CF4B4CE97D3FD3DED42910694FF092280BE63ACD40A5DFB5A818CC8688EC086E8BDDC682D4738F2F5B9161413634FF009B7152107B6D40DCE28D499FB75B7669C2822C7CA73E1F97C466C8789FCC4F15340F7753CC663EC57BE369F16C04A1F6505793AB666438371A39A62CE2E6B835789522807BBF507973E68DCD0C5D8DDAE529C53977D0508E5CD9F29EDF979031A1647ED200F69A0B189380F73772922EB6BD04EC2D8DCE92428C00B9C7800029A0C9F43F5141879F999D90D924F9925046509F16E0093C10507A9FA4BAF63F5381D9F047235AD0E6796EE0E002E9AEB4073A330C0D7464918EA3633442478BD9404F2896C24AA781072D75A0674BCC931E5872630D732489AD9DC9E101CF517E741A3C98F2E4EACD31ABA1735AEE6E703FFA40A0ECB6BDF16E42C571DA5DC434A2F75061BC1FED8DFBCA7EA3B93B3E6D1283657A0692ABFB2502B768239EB415FAC86BFA7398E28D2E6EE2792AD047D1F1E182139B3787714671B7BA80E439F88D25C256B5A4DDA8554F1D282D48F70690DB38D813A5E819BB6B034BAEB7B8A019D670E3959F331A372A31678FCCDD36BA806445AF89A4B0B7794705E47FB2829FA8BA78CAC095880EE6B82270341F2CFA8BA6C9D3FAACF8EF09B5C53BA836DE81CC2EF4FED26F8F2BD9DC0A38501EC8CC6B63602547E52791A08864B2C8493A1341721C96BF7B0820B74EEA0B11BD004284F1EEA0B2CE9DD37A9B9AF9A47B656F85D1176D53FC439D017C1E8B8B8CC2F862B0452E3BB5EFA0250748C874724AC8498E301F2A68D06C09A09A3E992CB8D24AD6AC7111BBB8D007CCC764723645422C40E54194EADD51C269316290B9C423D0D83791EFA013869F3252F6414157D59D4BE5BA5BA3628972088801A81AB8DBB2D4190890469DB41ED3E83C67E27A4E0716EDF980E78089727E2275B8A0D574E203BC5F003A272E341673A40C80F98E0C61F0971E0D3AAF6D03BD3EE8E0CB9316073726191A8A2F1B5BFC45F70D34077A8F576751C93D2FA31272650239B2C14646C1A8047E641413E53C4622C71B9E62606B8F0686A00B4186DFFF00C3F7593E6976F14F9BA0D806DBB281AEBE9AD0285DDADF80A08F3E32EC7634E8646D8FE3417998F14B0089CD5628200B69401E4686C9335480D710175A03D94D7CB80E8D83739F1041C550141419E747B7734D9E0F1056DD940664639BD35AD7104863413DAA2EB4039ACDCD47042BA9D480681D33D823DAE0A5C1138A50784FD60F4F164BF3F130A32CE70A005F4FE0963C5CA32121936D746DE3E1504FB5680A66CEE895AFD2FB5469D941561CC7B51A1003C4EA940531B3B6FC4744A0211E4DF54ECE540F398C0A1FE1234340F6FAA73B001FE5FCD45AB4290EA070FAB4FC6043FA5E4BAC8402DB8F7D0549BEAF75994BA3C1E8B2A3AE92BB681DA505005CBF537AB7A8484CE63C38CD8B62F1393BCD0576E4BA16962AADDEF25493DF40FC7CC491CF5B32EA68333D7BAA9CC06427F971B808C0E039FB6834DF4D70707AA654EC788E431B5AF8DB20054ADC069D683DBB1B06676288228C4B904964718218C41DBC2809F4FF004D7546BA5F3DAD67E6690F0412966D85BBE81F91D072F6B7E61D132E4963497145D05829A015858D14C258993FCAC6E738BA0162584EA791B5E80974CC2CB804716249E5E2EE0D21A55E4AA9D1777BE80ECB8C5CC7C700030E32E32CAF75CCB6B6E3C02D061BCBFF00E11F1FFC6D52DFF50AB41B39B1246025BE26F66A282AD8DB437BD02B4A71E4B40CCD2040CFFF0023682FC4E2D8C387DB7A04970F126709261C2E59655E1A505D2D02EE52C4DA00D00E140373FA7BB2272F8886B481BD75B72F6503F38B5B86468DF08278D92D40258E649182D712D26C4D93DF40C3B94079EE53418CF5F604791D1F2F7BC111B4BDCBC85ED41E61D324106431A3C10B9BB4B470B5968094F132781C0A9E4EA0CECCE97127D92DC1D1DC2D41660CADE837DD14723406708C8E010E9AA505D762492BAF707416A073301EA18FB70DDC8D019C4C3E9B8CC0E963F31E78EB7A01FD726C531BFC88B692351AD0008226CAC2D6A9429745A0872F0C3232E79441A25065BAAF55735A71A375DDF111AA500F38F23FA6CB27E5047DF405FA16FC48A3923798E550E6C82C5BDC683DEFE96F5897A9C58FE74A1F9104A5B2AEA439A5081DBC683D5A302E5556802F5DC319F85958EF7EC1B577A5C6D2A13DD4195F4C4192EF98C286489EF8FF0098F01A4170174DDCCF1A0D2450E67F45CC7E3E3393CE0C25C5C4F2705DB4173A84F0B3A7186748A28CB7646C280F252405EEA0C4ABBFF1FEBFCC4DDC3FF7B7506E71F2DAF46E9DF4093C103DA5E51845CBB41EDA01C0A5043D45C3E5D9A217B6C74A0238803E2692369D535A082674B1F506431B888C2103876934051C5DE5EA9CC505499D1B1BA969E601D6822306265CA209DBE735A37A151E20516828E567FA4BA6B9ECC8CAC5C773ACF6BE405C9C91491418AF50FD4EF49F4C6490F43C76E7E53C23A63B844D4EFF0013BD941E65D4FD77D773A0971267451E3CE55EC8A302CBA2DCD00C73DDB43DA7C6D43C741C2F40770656C8C0E214102825EA1D163CD84F846E02CEE3418ACA872BA74C3CC04C2D36900B8EFA033D1BABC6083BB5E4556835F879B03C34B08DDA2D8DA81D979918780D04EF50E776F6D0559339A236DC6A7554A01F9D9DBA3DACF8A4242AAA0A08F1E56E3441CF70053B168331EA2F52EF26288A916FEDA0CF74FC49F3F31AC6AB8B8F89D41ADEA7831E2F487C005C314A6AA2F4157144419183F0B82A8A0F4DFA3DD463C2EA1D48BA46B1DF2A1F1EF1F984813EC2683DAFA375CC5CDC3323A463656BB6B9A0F1E1AF31411F502D185992259AD7151C8368305E8EEAB2B65C9C28A395D3BE792679601F0310300246BE2E341BC6759C41D3D8F2D763B58435E677B03C9E2034124D0249E54B09CCCA8437C09009078C3AFE23C05062FC977FE3DF806DF97DDBEE8BB9556836AC7C3202F66D22C49E2A2801FAABA8E4797074BC724646490E91C350C074A0B58CC745032224B8B0005C6FF6D00FEB1D73A463C4D8F233216B81BB4BC12139814159FF0052FD2384C206519C816F258E77DA505007CBFAD3D2D80FCAE04AE785F14AE6B553B83A82077D75C0DA3674D787BB8196D7EE6D00BCBFAED9A416C3D3616720E73DE9FF00A6832FD73EAB7AAFA98730E40C589E363998E3CBF0F22EF8BEDA0C8BB2657B94B893CC953DF40AEDC1A000AF76ABDF40D9619191973ACFD4269416E23E646A6F6F13BF72D012E8F36C788DC5034FECB41A7C6735E1004E2795047D4BA463E531CC7B478BE2046B4182EAFE97CEC299D374F25CC054C3C53B2807E1FAA32B164DAF06378B107850171EB881D1A4ABBCDB737B78D04337AB71C03B4975B55E3A50533EAC6314B584BB9500DCEF5166E4D9763510D00F8209B2260C8C17C8E3DE683D23D3FE9C6F4CC2124C3FE6240A7DBC281BD62232E3C8D165047D94023121F2B1DAD75CC62E48E541B2FA4F990657A832F19B206E5B981F0C6A01731AA5C1AB6F6507AC27CA63C8F18CF1E273E40D00B9CF40A75BA0A09F1FAB79FD024C4646F74D3B5D1B7C2E251ED3F15054FA798F3C3859B91344E832722649637020A44D0D0345D54D0681B1F4E6651CBF9527249BCA6324A8E22DAD02755EA108C0927712039A6CFB3BBCB68017CB4BFEDCF9CD9FF69FD3D766EB2F95FF00B6BFC57A0D187458B8CF91C4EC602E79255C9AFF0065079F65FACBA4F4ECD9F3F39DE766C84F918CD20968D2FCA8311EA2FA8DD6FAA38C70BFE571D53C961427FCC45CD064E5CA91DB8BA42F26FDE4D042669740FF000EA02E940C92690A5F9EBAD0465CE3A145E7EFA063DCE1A9B9E3A9A066E21C420B14D79D02C77758211416B19A5F292BE1683EC340ECE0035C0108020E2B40DE9D297C41AA6DAF154E7417209BC999B25F6AF881FDB5A0D760B83981E0A820104501585CD7D9F7B785C3514157370D46E2039A7470E14003A8FA6FA6F516913C23CDBED7B103BDA683319BF4E72184BB172039BFC2F171ED140266F4775C8BFE1078FE26951415A3F4DF5B91E5ADC47A8ECB5017E9FF004E7D4192F6F9AC18F11D5CF341B5E87E8EE9DD201907F3A7010BDDF8504FD57A86262B52672C86EC8C6A7D94195CBCE9B264DCE0191AA35A2FFB1A011D433C35BE4C7627522824E87E760B8F508E67C396DBC5230A3989C41A0DD746FAC3EA3C50C8BA806F5085543DFE192FC770B14ED141E8FE97FA83E91EA2D8D9148D832434AC53B431C5C79389DAEF7D06CF0A5679729633633C2486B8924BB885274A0BCC972268B6C01B196045706924F3A083A889D9D32712B5B2CA62785DA06DF09B20A0C67CCE7FFE3EDBB5CBF2DB76EDE3E5F3EFA017F533D7B161C3FA574F903B224B4D2B4A860EC2283C76498BE42E738B9C4971792AAA6822924721BAEBE2A087796FEFA0E7238DAF6D1B6B5026E6D9ABF6292BAD034D892D3A8E3CA818B6BF3B72340C51B8DB8EB41230B5095FDF41730C011171FCC482BA72A06668561E251003AD051C195D1CEE8F813A6940508F1376DCF3075A029D2BAC0C7FE5C8BE4AA13FC27F7506B71266C8D05843D8E167036A0B2F610DF0DC716E9415A485AE0A421E47F0A085D8AD20824272DC681A31A3164DDD8E361ECA0B70421A2E8DE42D413E565E362C264C991B0C634DC6E50294A0C7F54F563E50E8F01A628CFF00C670F111D8DE14006425CF2F937389BB9EE55F6D00EEA39ED0101BAEB403B1A27CAFDF741406240C6E13DC2C6CD68EF3410376A6E360380A0702EDB6B3485141A8F4C7D45F53F400D8E09FE631426EC69FC6CFF49F89BEC341EBBE95FAD1E9DEA4E8B1B39BFA5E4BBE22F3BA224FFF007387B68359D6BAA327E9797F29FCD8FC890F9AD2AD236142D228323F2BD73FD81F2FF2E13E5FFADBC2FF004F5F7F6507887509E49242F994B89B926F4155AB729C6D7E141C7E1D2DDBC681AE40EE43E203803A502124120853A76502075C06AB48A0E7A5EC8789A08884420227DAB409B4B9C8A97B2502B80632DC753AD0138231E43344D57BE8239C3F47041F6D051108F343B4BDB9D05A932F0E16EDC9998C7A290A147B05054775EE94D711E639E386D69217ECA0B7D2FD47D4039ADE9D14B239C53610AD71E00340268375D37D463CDF92EA90C9819CC037C790C2C6DC28454228089D9202E8DED78E6C7070A081F340C244923185BA82E0D2BEFA0AB99D77A66226E943DC746448F70F75008CAF59E5386CC185B083632C88E7A730DD05067E79B2B26532644AE9A43ABDE49D7EEA063A56B19E2360083A1141472FA912AD67109ECEEA0A1062BF2250483CAF405F1B1191789C74B11C52819D49F1B658E06587F51FDC2C282346BD4127B387BE8116D75ECA0E04D869CBF0A050E208BAFF00113406BA57ABFAE74B865C6C5CA7B31266EC9B1D5585AE087C2742472A0F4DFF00CDFD3BFDA7F27FA6C9FA8F97E4ECF307CBECDBB77A6BFE9FB683C9B2E51B9500E4354A081A017121CA4D9281E8A4006F7DB40AE2012B7B5DBFB76D047CB991EDA0568690553770A0E540A48F0F0A085C795D0A1340E2C69683A937245074A518740BA000D0359D60C0C2C9316503F8DA8ED3B281B375A748D0D87166948D0B86D4ECE340326775ACA25A4794CFE116FB75A09B17A243B099564916F7297A0B8CE9F8CC0B1C4D51A14A0DA7D353911752C87E131B26782D10B491B8307C5B541E28B6D280AFD50EA99994C864CD8587A9472B9909501C6200EE360DF0AA25A8300D9240C2F6B9D139DC9C86DCD282ABA2C8648F9A190CBB8F8A393F373EE3CA826C19F1B20BA26931CE2C6170475A82FB5A05DE14F0096B5042E249739B62797DD7A0AB247249771B1BEC056F41D0F4F0E2778E26FCA82D3606C48036E2F7D5281F3C8C82174B3046005C5398FDF400E0324AE7E449FD494AA1BED6FE514169845835148A069DD60027DD41C6DAEA2E08FBEF40E0092174D3D941CA09048DA8389D7BE83ACBAF85282FCA0120390DAE4733A5057739ABB48283EF140E29AE8352BC2816FF0010E1AD0222B8026E4E9FBE81C114828174A06C8F376A0F0D043DD73A0034A0700425B85974A0E9C46034806C1013CC503233717B0D682D395ADB14DC74ECA0AC37EE24A2F1A09184ED41C74A0702E682D78570175E740B87933E3647CC4123A29E321D1CB19DAE69E608434163272F2F26774F34AFC899FACB238B9C4F6B8AD0405AD6F84A03C49A06BC80D4017883CC50569B0A3990BC16CAD28C7B4A3C7B68258FA8E562B8479A5D3638B0C968F101FE368FBE808364C696106270735C7517078D023D8C6B46D52874E740F89AD05477A76D035F39703C0000B9E4E800A00B9592ECF9804230E32B184BC857E27765028080B750AAB413781576804D9072A0421C88848B29B5A81923B71BAA733D941CA0B5A57704A07070DC55A1C35A0E577208BA50107EC51C43B4F650432B4978B58F3A06B136AAF67B2814EAA35160BF7D07375E64FDE283B91542B40D7BEE9AF0BF1A06B141B8B8D05038007C27506C9CA816544038103DF410B1551C80F05D2D4165A016150BDD40C6105545C502B1A6CDF7DAC2839ED01C4137210916A0742220D22E53DBA502B65768084555140A183783F15AC11541A0E7441CD7394168B1160BC7ECA0818A3C5753A5038DC769175A08BE5BCB90C98F2181E6EEDA85A7FCCD3634120CFCF67F56012464A2C453FF00A4FEFA06BBAE0634B443334B78962D0537E6CD9AEF22263990AACAE236823F87DB41308D83E1B04BD071DA89C2CBFBE814786EEBF0140E01C849F0AE9FDD40D40D20BAFDD41CF6B4DDAA84E8B40DDC6E855002B408922FC17A0232BD0A59790E00D024C9B5A4212E017904A0AE1381BF04A075DC9753F85038AB6DA76F1A070D5A3BD68219492E2EBA11C28102A802C3F7D04A1A82DAA212785074C370D42E8B415C2A80EFBEF4166100071ECD2839E2E081AD0231CE051A2EB6BFD940B29051025F5340D646480E69470BAF7D0399B9A2ED54450A940E209215CD6D8A0D681929FE5B9C5DE2080029C7541410315C50D89B8234A07B5CE2F07769E2ECD281C80F1D16DCE8232F7072952D4B73ECA045B0FE24A0E5408D3DE79D076D2401A0E3DD41C0201DBF750712340147134086E4A0D35BEAA28180950E171C57B2814808AA45941141DC5C16C3DE6813C3B75B73EDA0BF216EFB270BF6F2A06BDEDF29A111095234A08B6B154BADCA8242D3B500553614085A8836E9EEA0687BB7024697A0E782DBA045E0AA868102291AA9B0E24AD039B65E00FBA815DBB62DBF03415DCD731E6D7201BFF6504EC3621B63413B8B5CDDAEB01A71A08589BB6928797F7D073F50D5B73E412824F0ADAE0A6D6F7F1A052C25C846D3A02071EEA0EDA6E5CD04850D55053B28209802CE4E1C35EEA0818A6DB54EBB681E05F69E5A6B40B234D8B480BAD023953894E3F65030868F1722A00D528389280826F62281E4EE0A9F09F7502280EE674EEA052D68E3C92818547849B270D50941408768B285E141C4383769BE89DD4082C87720E09D940E46A6E43CF82F2A0B2FF137CCE1C3B4D02B58483B9549B1D6F40D162545B88363409B9CAA0D89E1CBB681CE2E521EA2C9408C01BA95FC281A6EBC02F850502464192C084B1341333C455A375B4FB1681E18405703DA08B0341566087C36FC528160E1B87145141623738466CAE37EE5E22819E59DFB9DA734B1A0E24077670D2C09A0DE7D2BF47E2FA97ABCC7A86EFD3F0582592388A3A42E3B5AC0782F1A0D9FAFFE97FA75BE9DCAEB1D0A07E33F0407491B9EE7C72465140DF7046E141E2F280D56150E5B9E434A0AD3069039ADCF3A08DAAA01BDD546B41C6E02EBCE8150A8BDAD41C84B9023485B9D1681B2376A120D914F3A06B9AD2AB64D1DA50773254AF1FEFA0E0770503B89FDBB681012001C782D0735A46B60B73AD035DB5CE210A0BAD0712405D4201DB41CD4370354A04DE34DBE1544A07F8E37787C4DE3A84A09A195CF690546DE3726F40A40048BEFFDB9D070DBB8EFD16C97F7D073C0002ADF53DD40E8D4855B6A1682273D4A6A751C281F13000E712A0E8470A0923739AE2D1C2FBA8251210C0CEC55279DE823C80A781D0AF6EA96A0A6C2E0F2B60741DB416C2ED0E373C508A0E7B5ED6287283AF3F7D03632CDE5A5AA85149B2506BFE9FF00AD327D27D58E640C1918D337CBCAC6794DED55D7811C2836DF507EB347D73D3F2749E9985F2B04C1A32242E0E7103468000B5A83C8E691CE7798F24EEB1ED4EEA081E09692D72916D28208DCEDC9A00B73C0503DE0A29D45FD940846E5DC38272EEA046F1E46C9C168111A84388042AA73E42818C2576A107445A05DA80ADDA6CBF6D034AEE453B795035FF127DBCE839C84A03FBA8112E5C0EA9DF41C01FF0028EDE340E0E6B5E835E3DF41DB4EEECD538A504D282A0941745A07B48010945D5DDA05021009BFC3ADAF408AAE72680228A050A11492D364E541231E0B50052753FD941038200555CB6445FEEA073256A9288A2FECB76504B7441FD3B5F89A07169009768470D6FA5020DFB4B76FC286FAA5053943A32D4D554A505B63894423811C281EE17F0A02972B6A085A180124ED5BA6868258C381DCA965FECA07BA476E0D24807E208A6810BDC5C1ADBEA7BB85031E5CD6A0088A579D040DDA0F8C28E07EDA073417168E1C0DBDD41CBA294B22D021E009B5C93AA5035E012BB940B1B71A06B77972D80BA1A04DCD51BCF87821BD0238B88569D3B38D0235091A8ECA0E3B771BAB681A1AA492554D071243B69F172E5F65073802410840553CA83BC3AAFE64F669EEA0B0F04ADAD75F650240E47290A7F2F10941212D2ED3D8281B70EF0E8BF85E8150EDD3C4975A07342B411F08D785046E4BB87C40EBCE8231AA107984E3DF41603BC2174DC96A0504A10C2769445140D2E735CD7B816A9B9EFA066402012BA13B41097A0762481C2E2E156DA1EEA09082E0587E176B6D282274603B69728E2281CD79D76DAE8BAD03C027C475D368D79D035DFCB2117B46BED51412CA4168360BF08E76E5415890840201D54D8D0744A75BF68E140E2856CA52DAFD941CD4721363A169B50303404B9516268108D5AB6074EFA068E0B6455280D026DE22CD1A0FBE81AFDC0022EA50FE141C7C6E5441F65026D210F151C9281B75436701A8A052E603617D3BE8112EB74A0B4E04DD502DC5030B804B929A916A09F6206A2171FB968185C078F5E006B7341DE3DC422037D681C01FCBA1E7AD029680A45C71A08A420351108B844E14091C8E1C11A744D7D941335ED6AB5094F7503490E552A0F0A0739BBE269DCAF68BF3B5040CD6D606E9A0F6D05988843E2BA03AA29A085E76971BA93C6811A0EFB1B6AA74A0943818C1096256F40B62F0896D78044A073802C04DD57437A0AEED85BB9C7C7C7BC504AC1B90EA4A14141A9F4BFD3CF51FA89D19C0C70D824716B32663B63714B8078FB2835527FF00E7EF52004C79D8AEF08712AE0D37DA9B8F6DA830FEA5F46F5BF4F4EE8BA8E3EC0D7166F69DCDB68145067DC51D7D08FD9681BB43085D4EBCB95035CE3B6F63CAD6A04696EA05BB68151A54827440385044002884AF0B5038176E5727EEA04710D09F17EFF6D036E9A5B9AF0A0959229D87871D6DCA8154293C38D04F178A269360796B6A050D610484D75FDF40A01691B827DC9ECA0739CE2F2484601A0E3408F2434E84F1ED5A08CB0BC97258590503046EE163C08A07025CAB723C2568151EC3F1272206940E8C9F31C0DCBC20EFA089EA1C38A6BDF40E738B62DCD29BB95031AE5F8AE83E2A07004B6D61AD03C2ED693A0BA715A091AAE2439D7049701C49A0446050F692E16B5046F6B485D1AB6B506C7E987A423F527A9A1C39CF9789134CD39E2E02CD60FF0031141F4CE260418D8F163C313207323168BFA2DF2CA077638696D682CBB072246CD24199B65980D5A08681A0683A500BEB5D123EAF8395D3F2E266440F88C660D9E3F388FEA3A43A5EE1283E55F55F429FA175BCBE99293E663BCB438A5DA6E3ECA00E5800E6350681AAA896DD627850215234B6848A042538701B56811FB800D28001AF7D035BB828B2733CA81AAAE0814B78D0729DA9B8272ECE5413C91B4BAD606E940C95EE682E5E1C681D82E2633B9C800B1A09C23828D5084A056EE05A0B50F1275A09435CF79DA15B746E9A0D68181ED046FB15E140D1724B6F643BB4A08DCE5202F153C281AE01AFDC2E398D282469796A908DE5CF8D023D0315BF94A8E6281F26D91AD7B4843F12715BD0401BB9E54E9CA8347E80F4962FA9FD4F8FD33232BE5619373DEE6A1739AC05C4356CA68367D73E9C74C7BF2A1E8988F0CC60FDB941E64692C5DA5EA4FC5B0D07976D00D97C3AAF2A07C23C4E710458009A92795029716CE5A81DB86A0AD0216128BC2E47E341E9BF43A2664E6F52C78DCC6E496B1EC528A1A5D65A0F7DE970323271CCEF793B7CB7BC203E512AD6AEA38D04F3C1991BC3D8413FC416EE26CB415E4CE89D97242CC98DB3785877B4B9AF3C7429D941F35FD68C8825F5FE706BFCCF29AC648E1657A2916E4A283085500D1743CD681B6B104A77507280E4B9E038507292C164BA85E0940A77120FC4E2795031CA751B178D034B0A12AA9AE8B411A0DDDBAECBD0592551BD880FE1ECA0A9947C0575D139504902B48012E05CE8282D391405B8ECFBA8257AA8D09A07B086785A2E45F40A3DB4119166816BA0B8B7B68148DA0B4A97151A823DB4113C3411B812BA5021B0D10016E2A681632D2D0B62BB87EC2815AE639CEF6EBDB40B17858582E1575FCA682091B2179746435E0785458F6505CE95D4B33A6E7C59B8AFF272E021F191E2450857B1283567EA275DF2A76E386E3BF35862C990171569084004DAC7B683213B9CE7027E201140007D94091168894594AEB6E540D914B9AE036A597B78D048E0D202E9C483C385015F4A7A8723A075983A863377065A684E8F6710A7DE283E91F4DFAA7A7F5EC06CB8592649F2003338A6F61FC8DDBF96835C71F21B0798E9247318402D73BC2E68D6F41E73F503D61D0FD34C796CCDC8CF91BBA1C4611BB79E7B6CD68E741F3AE767E466E54D9792FDF3E448E9657F02E76A9C5282BB802D5545A089A41054A05A0E77C7BD6C742283ACD080EDDD75D53BA811D2ECB8771255744E541566CA4F0B4DF89EFA04827205F5D56827DD7DC97554FC282D787F3689C39D00DCF5DCCDCBE5ADD3FB2826BADBD8B41619E620B055F095A09879BE51FB79D0399C5372F0E4940E66DBA7C2A53750365FB6DA25021DAA36ED5409FDA94113916FAA1D79D031DB12CBECD681C1363745B27776D04813CE6A7C49C79503BC3F32ED17F272E09ADA82ABB7F9C7726F5BD05CBEE6AF2F0FBB85036DB7C28ABA9FB35A068FE98444DB6A0E937205E76EFA07B7E02BF028EE5A0E3BF7F8755E3F6D05FE91FAC7CEB7F4AF98F9D4FF00F977EFEC5D9C3BE83693FF00E6BFD34F9DFA97CB25F45D3FC3E2A0F3ECBF9BF364F9AF33E6377F33CC5F3377F8B75E82B84409F076F34BD038FE65D16E9F85044DFDE9EEECA073D542FC29FB6940D93B17409C9282A6479881136F1A0A435F17C5C282767C56F6A5059A0FFFD9, 10)
INSERT [dbo].[Profiles] ([Id], [Name], [Surname], [Phone], [ImageData], [AccountId]) VALUES (2, N'Artem2', N'Mazur2', N'9564545656', NULL, 11)
INSERT [dbo].[Profiles] ([Id], [Name], [Surname], [Phone], [ImageData], [AccountId]) VALUES (3, N'Artem3', N'Mazur3', NULL, NULL, 12)
INSERT [dbo].[Profiles] ([Id], [Name], [Surname], [Phone], [ImageData], [AccountId]) VALUES (58, N'Artem', N'Mazur', NULL, NULL, 64)
INSERT [dbo].[Profiles] ([Id], [Name], [Surname], [Phone], [ImageData], [AccountId]) VALUES (61, N'Artem6', N'Mazur6', NULL, NULL, 67)
INSERT [dbo].[Profiles] ([Id], [Name], [Surname], [Phone], [ImageData], [AccountId]) VALUES (63, N'Artem5', N'Mazur5', NULL, NULL, 69)
SET IDENTITY_INSERT [dbo].[Profiles] OFF
SET IDENTITY_INSERT [dbo].[Seances] ON 

INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (1, CAST(N'2016-04-05 18:00:00.000' AS DateTime), 1, 6)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (2, CAST(N'2016-04-01 14:00:00.000' AS DateTime), 2, 6)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (4, CAST(N'2016-03-23 20:00:00.000' AS DateTime), 2, 6)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (5, CAST(N'2016-03-29 09:00:00.000' AS DateTime), 1, 24)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (6, CAST(N'2016-02-20 17:00:00.000' AS DateTime), 2, 24)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (7, CAST(N'2016-03-17 11:00:00.000' AS DateTime), 1, 25)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (8, CAST(N'2016-03-17 18:00:00.000' AS DateTime), 1, 25)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (9, CAST(N'2016-03-28 10:00:00.000' AS DateTime), 2, 25)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (10, CAST(N'2016-04-05 15:00:00.000' AS DateTime), 2, 6)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (1011, CAST(N'2016-03-30 22:00:00.000' AS DateTime), 1, 6)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (1013, CAST(N'2016-04-03 21:00:00.000' AS DateTime), 2, 6)
INSERT [dbo].[Seances] ([Id], [DateTime], [HallId], [MovieId]) VALUES (1014, CAST(N'2016-04-29 21:00:00.000' AS DateTime), 1, 6)
SET IDENTITY_INSERT [dbo].[Seances] OFF
SET IDENTITY_INSERT [dbo].[SeatTypes] ON 

INSERT [dbo].[SeatTypes] ([Id], [Type]) VALUES (1, N'Single')
INSERT [dbo].[SeatTypes] ([Id], [Type]) VALUES (2, N'Double')
INSERT [dbo].[SeatTypes] ([Id], [Type]) VALUES (3, N'Single4D')
SET IDENTITY_INSERT [dbo].[SeatTypes] OFF
SET IDENTITY_INSERT [dbo].[Sectors] ON 

INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (1, 1, 4, 1, 10, 1, 1)
INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (2, 5, 7, 1, 3, 1, 1)
INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (3, 5, 7, 8, 10, 1, 1)
INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (4, 8, 9, 1, 10, 1, 1)
INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (5, 10, 10, 1, 10, 2, 1)
INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (6, 5, 7, 4, 7, 3, 1)
INSERT [dbo].[Sectors] ([Id], [FromRow], [ToRow], [FromPlace], [ToPlace], [SectorTypeId], [HallId]) VALUES (8, 1, 12, 1, 12, 1, 2)
SET IDENTITY_INSERT [dbo].[Sectors] OFF
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 1, CAST(100 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 2, CAST(80 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 4, CAST(95 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 5, CAST(40 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 6, CAST(100 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 7, CAST(65 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 8, CAST(120 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 9, CAST(66 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 10, CAST(89 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 1011, CAST(70 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 1013, CAST(120 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (1, 1014, CAST(2 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (2, 1, CAST(120 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (2, 5, CAST(50 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (2, 7, CAST(75 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (2, 8, CAST(130 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (2, 1011, CAST(100 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (2, 1014, CAST(3 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (3, 1, CAST(150 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (3, 5, CAST(60 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (3, 7, CAST(90 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (3, 8, CAST(150 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (3, 1011, CAST(150 AS Decimal(18, 0)))
INSERT [dbo].[SectorTypePrices] ([SectorTypeId], [SeanceId], [Price]) VALUES (3, 1014, CAST(5 AS Decimal(18, 0)))
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'9c3ec10d-1a48-42aa-876e-1cd1c57bcb17', 10, CAST(N'2016-03-05 13:34:36.227' AS DateTime), 0)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'ae2ee03c-2a84-4503-be83-38a6b2980ec6', 10, CAST(N'2016-03-07 12:09:43.163' AS DateTime), 0)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'2eeee0a4-262b-46b9-ae0e-5e8185973d5e', 10, CAST(N'2016-02-24 13:05:22.590' AS DateTime), 1)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'88e6250e-64de-4322-a70d-6effc492243f', 10, CAST(N'2016-02-26 10:50:09.370' AS DateTime), 1)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'bd7e586c-c711-4219-b133-91f841b55f72', 10, CAST(N'2016-02-25 15:31:03.327' AS DateTime), 1)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'c4047104-903f-4894-8d3a-af51883004d3', 10, CAST(N'2016-02-24 13:09:00.717' AS DateTime), 0)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'67aea807-20f7-4aa1-8a88-ef97def6832e', 10, CAST(N'2016-03-05 13:50:13.670' AS DateTime), 1)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'ccfe3f34-30d4-4b63-8242-ff075bcf24eb', 10, CAST(N'2016-02-29 13:30:56.257' AS DateTime), 1)
INSERT [dbo].[SecurityToken] ([Id], [AccountId], [ResetRequestDateTime], [IsUsed]) VALUES (N'd957ffa3-715e-4662-8aa2-ffbbe22356cb', 10, CAST(N'2016-03-02 12:38:40.077' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[TicketPreOrders] ON 

INSERT [dbo].[TicketPreOrders] ([Id], [Row], [Place], [AccountId], [SeanceId], [DateTime]) VALUES (61, 9, 4, 11, 1, CAST(N'2016-02-23 13:21:25.657' AS DateTime))
INSERT [dbo].[TicketPreOrders] ([Id], [Row], [Place], [AccountId], [SeanceId], [DateTime]) VALUES (62, 9, 5, 11, 1, CAST(N'2016-02-23 13:21:25.950' AS DateTime))
INSERT [dbo].[TicketPreOrders] ([Id], [Row], [Place], [AccountId], [SeanceId], [DateTime]) VALUES (63, 8, 4, 11, 1, CAST(N'2016-02-23 13:21:26.437' AS DateTime))
INSERT [dbo].[TicketPreOrders] ([Id], [Row], [Place], [AccountId], [SeanceId], [DateTime]) VALUES (155, 10, 10, 11, 1, CAST(N'2016-02-29 13:26:44.867' AS DateTime))
INSERT [dbo].[TicketPreOrders] ([Id], [Row], [Place], [AccountId], [SeanceId], [DateTime]) VALUES (1208, 2, 10, 10, 2, CAST(N'2016-03-30 11:02:13.917' AS DateTime))
SET IDENTITY_INSERT [dbo].[TicketPreOrders] OFF
SET IDENTITY_INSERT [dbo].[TicketPreOrdersDeleted] ON 

INSERT [dbo].[TicketPreOrdersDeleted] ([Id], [Row], [Place], [AccountId], [SeanceId], [DateTime]) VALUES (10, 10, 5, 10, 1, CAST(N'2016-03-07 14:09:25.107' AS DateTime))
INSERT [dbo].[TicketPreOrdersDeleted] ([Id], [Row], [Place], [AccountId], [SeanceId], [DateTime]) VALUES (11, 9, 1, 10, 1, CAST(N'2016-03-07 14:14:30.233' AS DateTime))
INSERT [dbo].[TicketPreOrdersDeleted] ([Id], [Row], [Place], [AccountId], [SeanceId], [DateTime]) VALUES (12, 7, 8, 10, 1, CAST(N'2016-03-30 10:22:20.477' AS DateTime))
INSERT [dbo].[TicketPreOrdersDeleted] ([Id], [Row], [Place], [AccountId], [SeanceId], [DateTime]) VALUES (13, 7, 9, 10, 1, CAST(N'2016-03-30 10:22:20.477' AS DateTime))
SET IDENTITY_INSERT [dbo].[TicketPreOrdersDeleted] OFF
SET IDENTITY_INSERT [dbo].[Tickets] ON 

INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (27, 1, 10, 1, CAST(N'2016-02-24 11:09:22.117' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (28, 1, 9, 1, CAST(N'2016-02-24 11:09:22.117' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (29, 1, 8, 1, CAST(N'2016-02-24 11:45:01.507' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (30, 1, 7, 1, CAST(N'2016-02-24 11:45:01.507' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (31, 2, 6, 1, CAST(N'2016-02-24 14:31:27.587' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (32, 2, 5, 1, CAST(N'2016-02-24 14:31:27.587' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (33, 3, 5, 1, CAST(N'2016-02-24 14:31:27.587' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (34, 10, 1, 1, CAST(N'2016-02-25 15:36:56.070' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (35, 10, 2, 1, CAST(N'2016-02-25 15:36:56.070' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (36, 6, 4, 1, CAST(N'2016-02-25 15:36:56.070' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (37, 6, 3, 1, CAST(N'2016-02-25 15:36:56.070' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (38, 6, 2, 1, CAST(N'2016-02-25 15:36:56.070' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (39, 11, 6, 2, CAST(N'2016-02-25 16:13:53.813' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (40, 11, 7, 2, CAST(N'2016-02-25 16:13:53.813' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (41, 11, 8, 2, CAST(N'2016-02-25 16:13:53.813' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (42, 9, 10, 1, CAST(N'2016-02-29 16:55:10.090' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (43, 8, 10, 1, CAST(N'2016-02-29 16:55:10.090' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (44, 10, 3, 1, CAST(N'2016-03-02 13:01:05.583' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (45, 10, 4, 1, CAST(N'2016-03-02 13:01:05.583' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (46, 8, 2, 1, CAST(N'2016-03-02 13:01:05.583' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (47, 1, 6, 1, CAST(N'2016-03-02 14:29:05.853' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (48, 1, 5, 1, CAST(N'2016-03-02 14:29:05.853' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (49, 8, 10, 2, CAST(N'2016-03-05 14:03:49.033' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (50, 8, 9, 2, CAST(N'2016-03-05 14:03:49.033' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (51, 9, 10, 2, CAST(N'2016-03-05 14:03:49.033' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (52, 9, 7, 1, CAST(N'2016-03-07 14:00:25.347' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (53, 8, 1, 5, CAST(N'2016-03-10 10:14:52.793' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (54, 8, 2, 5, CAST(N'2016-03-10 10:14:52.793' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (57, 2, 3, 1, CAST(N'2016-03-17 14:15:14.017' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (58, 9, 1, 10, CAST(N'2016-03-18 14:31:30.917' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (59, 9, 2, 10, CAST(N'2016-03-18 14:31:30.917' AS DateTime), 10)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (1068, 1, 1, 1011, CAST(N'2016-03-29 14:08:20.883' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([Id], [Row], [Place], [SeanceId], [SaleDate], [AccountId]) VALUES (1074, 1, 1, 1, CAST(N'2016-03-30 09:05:44.723' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Tickets] OFF
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([Id])
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movies] ([Id])
GO
ALTER TABLE [dbo].[GenreLocalization]  WITH CHECK ADD FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([Id])
GO
ALTER TABLE [dbo].[GenreLocalization]  WITH CHECK ADD  CONSTRAINT [FK__GenreLocaliz__Id__5629CD9C] FOREIGN KEY([GenreId])
REFERENCES [dbo].[Genres] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GenreLocalization] CHECK CONSTRAINT [FK__GenreLocaliz__Id__5629CD9C]
GO
ALTER TABLE [dbo].[MovieLocalization]  WITH CHECK ADD FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([Id])
GO
ALTER TABLE [dbo].[MovieLocalization]  WITH CHECK ADD FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movies] ([Id])
GO
ALTER TABLE [dbo].[MoviePersonsJunction]  WITH CHECK ADD FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movies] ([Id])
GO
ALTER TABLE [dbo].[MoviePersonsJunction]  WITH CHECK ADD  CONSTRAINT [FK__MoviePers__Perso__34C8D9D1] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Persons] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MoviePersonsJunction] CHECK CONSTRAINT [FK__MoviePers__Perso__34C8D9D1]
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD  CONSTRAINT [FK__Movies__Director__35BCFE0A] FOREIGN KEY([DirectorId])
REFERENCES [dbo].[Persons] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Movies] CHECK CONSTRAINT [FK__Movies__Director__35BCFE0A]
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD  CONSTRAINT [FK__Movies__GenreId__36B12243] FOREIGN KEY([GenreId])
REFERENCES [dbo].[Genres] ([Id])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Movies] CHECK CONSTRAINT [FK__Movies__GenreId__36B12243]
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD FOREIGN KEY([PhotoId])
REFERENCES [dbo].[Photos] ([Id])
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD FOREIGN KEY([RemoveExecutorId])
REFERENCES [dbo].[Accounts] ([Id])
GO
ALTER TABLE [dbo].[PersonLocalization]  WITH CHECK ADD FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Languages] ([Id])
GO
ALTER TABLE [dbo].[PersonLocalization]  WITH CHECK ADD  CONSTRAINT [FK__PersonLoc__Perso__398D8EEE] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Persons] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PersonLocalization] CHECK CONSTRAINT [FK__PersonLoc__Perso__398D8EEE]
GO
ALTER TABLE [dbo].[Persons]  WITH CHECK ADD  CONSTRAINT [FK__Persons__PhotoId__3B75D760] FOREIGN KEY([PhotoId])
REFERENCES [dbo].[Photos] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Persons] CHECK CONSTRAINT [FK__Persons__PhotoId__3B75D760]
GO
ALTER TABLE [dbo].[Profiles]  WITH CHECK ADD  CONSTRAINT [FK__Profiles__Accoun__0A9D95DB] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Profiles] CHECK CONSTRAINT [FK__Profiles__Accoun__0A9D95DB]
GO
ALTER TABLE [dbo].[Ratings]  WITH CHECK ADD FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([Id])
GO
ALTER TABLE [dbo].[Ratings]  WITH CHECK ADD FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movies] ([Id])
GO
ALTER TABLE [dbo].[Seances]  WITH CHECK ADD FOREIGN KEY([HallId])
REFERENCES [dbo].[Halls] ([Id])
GO
ALTER TABLE [dbo].[Seances]  WITH CHECK ADD FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movies] ([Id])
GO
ALTER TABLE [dbo].[Sectors]  WITH CHECK ADD FOREIGN KEY([HallId])
REFERENCES [dbo].[Halls] ([Id])
GO
ALTER TABLE [dbo].[Sectors]  WITH CHECK ADD FOREIGN KEY([SectorTypeId])
REFERENCES [dbo].[SeatTypes] ([Id])
GO
ALTER TABLE [dbo].[SectorTypePrices]  WITH CHECK ADD FOREIGN KEY([SeanceId])
REFERENCES [dbo].[Seances] ([Id])
GO
ALTER TABLE [dbo].[SectorTypePrices]  WITH CHECK ADD FOREIGN KEY([SectorTypeId])
REFERENCES [dbo].[SeatTypes] ([Id])
GO
ALTER TABLE [dbo].[SecurityToken]  WITH CHECK ADD FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([Id])
GO
ALTER TABLE [dbo].[TicketPreOrders]  WITH CHECK ADD  CONSTRAINT [FK__TicketPre__Accou__02FC7413] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([Id])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[TicketPreOrders] CHECK CONSTRAINT [FK__TicketPre__Accou__02FC7413]
GO
ALTER TABLE [dbo].[TicketPreOrders]  WITH CHECK ADD  CONSTRAINT [FK__TicketPre__Seanc__03F0984C] FOREIGN KEY([SeanceId])
REFERENCES [dbo].[Seances] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TicketPreOrders] CHECK CONSTRAINT [FK__TicketPre__Seanc__03F0984C]
GO
ALTER TABLE [dbo].[TicketPreOrdersDeleted]  WITH CHECK ADD FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([Id])
GO
ALTER TABLE [dbo].[TicketPreOrdersDeleted]  WITH CHECK ADD  CONSTRAINT [FK__TicketPre__Seanc__17F790F9] FOREIGN KEY([SeanceId])
REFERENCES [dbo].[Seances] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TicketPreOrdersDeleted] CHECK CONSTRAINT [FK__TicketPre__Seanc__17F790F9]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([Id])
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD FOREIGN KEY([SeanceId])
REFERENCES [dbo].[Seances] ([Id])
GO
/****** Object:  StoredProcedure [dbo].[AverageNumberOfTicketsOnSeance]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AverageNumberOfTicketsOnSeance]
as
set nocount on;
select avg(counts) as Average from( select cast(COUNT(T.SeanceId) as decimal) as counts from Seances S left join Tickets T on T.SeanceId = S.Id group by(S.Id)) as counts;

GO
/****** Object:  StoredProcedure [dbo].[BookedTicketsOnSeance]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[BookedTicketsOnSeance]
	@SeanceId int
	as
	set nocount on;
	select T.Row, T.Place from Tickets T where T.SeanceId = @SeanceId;

GO
/****** Object:  StoredProcedure [dbo].[BookTicketOnSeance]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[BookTicketOnSeance]
	@SeanceId int,
	@Row int,
	@Place int,
	@AccountId int = NULL
	as
	insert into Tickets(SeanceId, Row, Place, AccountId, SaleDate) values
		(@SeanceId, @Row, @Place, @AccountId, GETUTCDATE());

GO
/****** Object:  StoredProcedure [dbo].[IsTicketBooked]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[IsTicketBooked]
	@SeanceId int,
	@Row int,
	@Place int
	as
	select case when exists (
		select * from Tickets where SeanceId = @SeanceId and
			Row = @Row and
			Place = @Place
	) then cast (1 as bit)
	else cast (0 as bit)
	end as Booked

GO
/****** Object:  StoredProcedure [dbo].[MoviesThisWeek]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[MoviesThisWeek]
as
set nocount on;
select ML.Name from Seances S join MovieLocalization ML on S.MovieId = ML.MovieId
	where Convert(date ,S.DateTime) >= Convert(date, GETDATE()) AND 
		Convert(date, S.DateTime) <= Convert(date, Dateadd(d, 6, Getdate())) AND
		ML.LanguageId = 1
		group by (ML.Name);

GO
/****** Object:  StoredProcedure [dbo].[NumberOfSeancesThisWeek]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[NumberOfSeancesThisWeek]
as
set nocount on;
select count(S.MovieId) as SeancesNumber from Seances S 
	where Convert(date ,S.DateTime) >= Convert(date, GETDATE()) AND 
		Convert(date, S.DateTime) <= Convert(date, Dateadd(d, 6, Getdate()));

GO
/****** Object:  StoredProcedure [dbo].[SeancesThisWeek]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SeancesThisWeek]
as
set nocount on;
select S.Id as SeanceId, ML.Name, S.[DateTime] from Seances S join MovieLocalization ML on S.MovieId = ML.MovieId
		where Convert(date ,S.DateTime) >= Convert(date, GETDATE()) AND 
			Convert(date, S.DateTime) <= Convert(date, Dateadd(d, 6, Getdate())) AND
			ML.LanguageId = 1;

GO
/****** Object:  StoredProcedure [dbo].[TopFiveSeances]    Script Date: 3/30/2016 4:53:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[TopFiveSeances]
as
	set nocount on;
	select top(5) S.Id as SeanceId, ML.Name, S.DateTime, Grouped.TicketsSold 
	from (select S.Id, count(*) as TicketsSold from Seances S 
	join Tickets T on S.Id = T.SeanceId 
	group by S.Id) Grouped 
	join Seances S on Grouped.Id = S.Id 
	join MovieLocalization ML on S.MovieId = ML.MovieId 
	order by Grouped.TicketsSold desc

GO
USE [master]
GO
ALTER DATABASE [CinemaDatabase] SET  READ_WRITE 
GO
