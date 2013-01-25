\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{ManuscriptThese}[1999/06/01\space
           LaTeX2e document class^^J
===========(ManuscriptThese\space Kévin Ottens, IRIT)============^^J
This class has been inspired from thesetb, JM.Rouet, ENST-Bretagne^^J
This class has been inspired from thesegauthier, Gauthier Picard, IRIT]

%% Possibilités Offertes actuellement :
%% 
%%%%  Page de titre automatique (option edit)
%% --> avec personnalisation de la page possible (chgt des champs par
%% défaut
%%
%%%%  3 Styles d'en-tte de chapitres 
%% --> option ChapStyle0 (normal book), ChapStyle1 (Chiffres en
%%     Grand), ChapStyle2 (numerotation ordinale des chapitres)
%%
%%%%  Quelques Defines de symboles mathématiques (ensemble Z, R, N...)
%%
%%%%  commandes pour produire les Chapitres spéciaux :
%% --> \Resume \Abstract \Introduction \Conclusion \Remerciements
%%
%%%%  Environnement Dedicace
%% --> \begin{ThesisDedication}
%%     \end{ThesisDedication}
%%
%%%%  Renommage de labels en style French (Figure., ...)
%%
%%%%  Option draft
%% --> Double interligne c'est tout !
%%
%%%% le package Caption2.sty est utilisé pour avoir des captions plus
%%   jolis ! Neanmoins ce package n'est pas toujours disponible dans
%%   les distributions latex standard... a recuper sur le site
% ftp://ftp.loria.fr/pub/ctan/macros/latex/contrib/supported/caption/caption2.dtx 

%%%% Choses a rajouter.... 
%%
%% --> Une documentation extensive ou un exemple détaillé
%% --> ????

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Definition des Options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Option draft
\newif\if@draft
\@draftfalse 
\DeclareOption{draft}{%
  \@drafttrue
  \@doubleinterlignetrue
  }

%% Option doubleinterligne
\newif\if@doubleinterligne
\@doubleinterlignefalse 
\DeclareOption{doubleinterligne}{%
  \@doubleinterlignetrue
  }

%% Styles de chapitre
\newif\if@style@chapOne
\@style@chapOnefalse 
\DeclareOption{ChapStyle1}{%
  \@style@chapOnetrue
  \@style@chapTwofalse
  \@style@chapThreefalse
  \@style@chapDefaultfalse
  }
\newif\if@style@chapTwo
\@style@chapTwofalse
\DeclareOption{ChapStyle2}{%
  \@style@chapTwotrue
  \@style@chapOnefalse
  \@style@chapThreefalse
  \@style@chapDefaultfalse
  }
\newif\if@style@chapThree
\@style@chapThreefalse
\DeclareOption{ChapStyle3}{%
  \@style@chapTwofalse
  \@style@chapOnefalse
  \@style@chapThreetrue
  \@style@chapDefaultfalse
  }
\newif\if@style@chapDefault
\@style@chapDefaulttrue % Style par défaut
\DeclareOption{ChapStyle0}{%
  \@style@chapTwofalse
  \@style@chapOnefalse
  \@style@chapThreefalse
  \@style@chapDefaulttrue
  }

%% Styles de couverture
\newif\if@style@edit
\@style@editfalse
\DeclareOption{edit}{%
  \@style@edittrue
  }
  
%% Styles d'entête et pied de page
\newif\if@style@shadow
\@style@shadowfalse
\DeclareOption{shadow}{%
  \@style@shadowtrue
  }

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions
\LoadClass[a4paper]{book}[1995/01/31]

\usepackage[usenames,dvipsnames]{color}

\usepackage{caption2}

\usepackage{minitoc}
\setcounter{minitocdepth}{2}

\usepackage{indentfirst}
\RequirePackage[latin1]{inputenc}
\RequirePackage{color}
\RequirePackage{fancybox}

\usepackage[lined,algoruled,algochapter,titlenumbered]{algorithm2e}%,commentsnumbered,linesnumbered]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Page de Titre                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Commandes disponibles

%% Commande               Valeur par defaut (rennes1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% \NumeroOrdre           --- (Champ Obligatoire)
%% \ThesisKind            Thèse
%% \ThesisDate            --- (Champ Obligatoire)
%% \ThesisPresented       présentée
%% \ThesisPresentedBy     par
%% \ThesisPresentedThe    soutenue le `date' devant la commission
%%                        d'examen~: 
%% \ThesisBefore          devant l'Université de Rennes~I   
%% \ThesisInOrderToGet    pour obtenir \\\vfill le grade de~:~
%% \ThesisDiploma         Docteur de l'Université de Rennes~I
%% \ThesisMention         --- (Champ Obligatoire qui peu etre vide) 
%% \ThesisAuthor          --- (Champ Obligatoire)
%% \ThesisTitle           --- (Champ Obligatoire)
%% 
%% \ClearAffil  : Reinitialise les champs d'affiliation
%% \ClearJury   : Reinitialise les champs du Jury
%% \NewAffilCategory : Ajoute une catégorie d'affiliation
%%    Les catégories préexistantes sont : Equipe(s)Accueil, Ecole(s)Doctorale(s)
%%    la mise a jour se fait comme suit : 
%%        \EquipeAccueil = {Departement Toto,\\ENST-Bretagne}
%% \NewJuryCategory : Meme chose avec les catégories prédéfinies : 
%%    President, Rapporteurs, Examinateurs, Invites
%%
%% \MakeThesisTitlePage  !!! LA commande pour creer la page de titre
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\if@style@edit
  \typeout{Mise en page selon le style de these de l'ecole doctorale de toulouse (EDIT)}
\else
    \ClassWarning{ManuscriptThese}{style de these non défini}
\fi

\newcommand{\@NumeroOrdre}{\fbox{{\tt\char`\\NumeroOrdre}}}
\newcommand\NumeroOrdre[1]{\renewcommand{\@NumeroOrdre}{#1}}
\newcommand{\@ThesisNumeroOrdre}{{\UseEntryFont{ThesisNumeroOrdre}%
    \noindent
 %   \underline{$\mbox{N}^o$ d'ordre~: \@NumeroOrdre}
    {~}}}

                                % Titre (THESE)
\newcommand{\@ThesisKind}{{\UseEntryFont{ThesisKind}Thesis}}
\newcommand\ThesisKind[1]%
{\renewcommand{\@ThesisKind}{{\UseEntryFont{ThesisKind}#1}}}

                                % Date de la soutenance
\newcommand{\@ThesisDate}{\fbox{{\tt\char`\\ThesisDate}}}
\newcommand\ThesisDate[1]{\renewcommand{\@ThesisDate}{#1}}

                                % présentée
\newcommand{\@ThesisPresented}{{\UseEntryFont{ThesisPresented}presented at}}
\newcommand\ThesisPresented[1]%
{\renewcommand{\@ThesisPresented}{{\UseEntryFont{ThesisPresented}#1}}}

                                % par
\newcommand{\@ThesisPresentedBy}{{\UseEntryFont{ThesisPresentedBy}by}}
\newcommand\ThesisPresentedBy[1]%
{\renewcommand{\@ThesisPresentedBy}{{\UseEntryFont{ThesisPresentedBy}#1}}}

                                % soutenue le ...
\newcommand{\@ThesisPresentedThe}{{\UseEntryFont{ThesisPresentedThe}%
    defended the \@ThesisDate{} in front of the examination comittee~:}}
\newcommand\ThesisPresentedThe[1]%
{\renewcommand{\@ThesisPresentedThe}{{\UseEntryFont{ThesisPresentedThe}#1}}}

                                % DEVANT L'UNIVERSITE DE TOULOUSE III
\newcommand{\@ThesisBefore}%
{{\UseEntryFont{ThesisBefore}%
    \if@style@edit {Universit\'e Paul Sabatier - Toulouse~III\\}\fi}}
\newcommand\ThesisBefore[1]%
{\renewcommand{\@ThesisBefore}{{\UseEntryFont{ThesisBefore}#1}}}

\newcommand{\@ThesisUFR}%
{{\UseEntryFont{ThesisUFR}%
    \if@style@edit {U.F.R. Math\'ematiques, Informatique et Gestion\\}\fi}}
\newcommand\ThesisUFR[1]%
{\renewcommand{\@ThesisUFR}{{\UseEntryFont{ThesisUFR}#1}}}

                                % pour obtenir le grade de :
\newcommand{\@ThesisInOrderToGet}%
{{\UseEntryFont{ThesisInOrderToGet}to obtain \if@style@edit the title of
\\\vfill \else \\\vfill the position of~:~\fi}}
\newcommand\ThesisInOrderToGet[1]%
{\renewcommand{\@ThesisInOrderToGet}{{\UseEntryFont{ThesisInOrderToGet}#1}}}

                                % DOCTEUR DE L'UNIVERSITE DE TOULOUSE III
\newcommand{\@ThesisDiploma}%
{{\UseEntryFont{ThesisDiploma}%
    Docteur de l'Universit\'e \if@style@edit de Toulouse\fi}}
\newcommand\ThesisDiploma[1]%
{\renewcommand{\@ThesisDiploma}{{\UseEntryFont{ThesisDiploma}#1}}}

\newcommand{\@ThesisUniv}%
{{\UseEntryFont{ThesisUniv}delivered by
}}

\newcommand{\@ThesisDelivered}%
{{\UseEntryFont{ThesisDelivered}%
    \if@style@edit {Universit\'e Paul Sabatier - Toulouse~III\\}\fi}}
\newcommand\ThesisDelivered[1]%
{\renewcommand{\@ThesisDelivered}{{\UseEntryFont{ThesisDelivered}#1}}}


                                % Mention
\newcommand{\@ThesisMention}{{\UseEntryFont{ThesisMention}Mention~:
    \fbox{\'ecrire \tt\char`\\ThesisMention\{ mention \}}}}
\newcommand\ThesisMention[1]%
{\renewcommand{\@ThesisMention}{
    \def\@tmppar{#1}
    \if\@tmppar\@empty
    \else
    {\UseEntryFont{ThesisMention}Mention~ {\sc #1}}
    \fi }}

                                % Composition du Jury
\newcommand{\@CompositionDuJury}{\underline{\UseEntryFont{ThesisCompositionJury}
Jury members~:}\\[5mm]}
\newcommand\CompositionDuJury[1]%
{\renewcommand{\@CompositionDuJury}{
    \def\@tmppar{#1}
    \if\@tmppar\@empty
    \else
    {\UseEntryFont{ThesisCompositionJury}#1}
    \fi }}
                                % Auteur
\newcommand{\@ThesisAuthorFirstName}%
{{\UseEntryFont{ThesisFirstNameAuthor}%
    \fbox{\'ecrire \tt\char`\\ThesisAuthorFirstName\{ author \}}}}
\newcommand\ThesisAuthorFirstName[1]%
{\renewcommand{\@ThesisAuthorFirstName}{#1}}

\newcommand{\@ThesisAuthorLastName}%
{{\UseEntryFont{ThesisAuthorLastName}%
    \fbox{\'ecrire \tt\char`\\ThesisAuthorLastName\{ author \}}}}
\newcommand\ThesisAuthorLastName[1]%
{\renewcommand{\@ThesisAuthorLastName}{#1}}

% Directeur
\newcommand{\@ThesisSupervisorFirstName}%
{{\UseEntryFont{ThesisFirstNameSupervisorr}%
    \fbox{\'ecrire \tt\char`\\ThesisSupervisorFirstName\{ supervisor \}}}}
\newcommand\ThesisSupervisorFirstName[1]%
{\renewcommand{\@ThesisSupervisorFirstName}{#1}}

\newcommand{\@ThesisSupervisorLastName}%
{{\UseEntryFont{ThesisSupervisorLastName}%
    \fbox{\'ecrire \tt\char`\\ThesisSupervisorLastName\{ supervisor \}}}}
\newcommand\ThesisSupervisorLastName[1]%
{\renewcommand{\@ThesisSupervisorLastName}{#1}}

\newcommand{\@ThesisSupervisorTitle}%
{{\UseEntryFont{ThesisSupervisorTitle}%
    \fbox{\'ecrire \tt\char`\\ThesisSupervisorTitle\{ supervisor \}}}}
\newcommand\ThesisSupervisorTitle[1]%
{\renewcommand{\@ThesisSupervisorTitle}{#1}}

                                % Titre de la thèse
\newcommand{\@ThesisTitle}%
{{\UseEntryFont{ThesisTitle}\fbox{\tt\char`\\ThesisTitle}\par}}
\newcommand\ThesisTitle[1]%
{\renewcommand{\@ThesisTitle}{{#1\par}\normalfont\normalsize}}

\newcommand{\@ThesisAbbrv}%
{{\UseEntryFont{ThesisAbbrv}\fbox{\tt\char`\\ThesisAbbrv}\par}}
\newcommand\ThesisAbbrv[1]%
{\renewcommand{\@ThesisAbbrv}{{\UseEntryFont{ThesisAbbrv}#1\par}\normalfont\normalsize}}

\newcommand{\@ThesisAbstractFr}%
{{\UseEntryFont{ThesisAbstractFr}\fbox{\tt\char`\\ThesisAbstractFr}\par}}
\newcommand\ThesisAbstractFr[1]%
{\renewcommand{\@ThesisAbstractFr}{{\UseEntryFont{ThesisAbstractFr}#1\par}\normalfont\normalsize}}

\newcommand{\@ThesisAbstractEn}%
{{\UseEntryFont{ThesisAbstractEn}\fbox{\tt\char`\\ThesisAbstractEn}\par}}
\newcommand\ThesisAbstractEn[1]%
{\renewcommand{\@ThesisAbstractEn}{{\UseEntryFont{ThesisAbstractEn}#1\par}\normalfont\normalsize}}


\newcommand\SetEntryFont[2]{\expandafter\def\csname @#1font\endcsname{#2}}
\newcommand\SetTBFont[7]{\expandafter\def\csname @#1font\endcsname
  {\TBusefont{#2}{#3}{#4}{#5}{#6}{#7}}}

\newcommand\UseEntryFont[1]{\csname @#1font\endcsname}
\newcommand{\TBusefont}[6]{\fontsize{#5}{#6}\usefont{#1}{#2}{#3}{#4}}
\newcommand{\TitlePageFontFamily}{\rmdefault}
\newcommand{\TitlePageFontEncoding}{OT1}
\SetTBFont{ThesisNumeroOrdre}%
{\TitlePageFontEncoding}{\TitlePageFontFamily}{m}{n}{12}{24}%
\SetTBFont{ThesisTitle}%
{\TitlePageFontEncoding}{\sfdefault}{\bfdefault}{\updefault}{17.28}{20}%{20.74}{25}%
\SetTBFont{ThesisKind}%
{\TitlePageFontEncoding}{\TitlePageFontFamily}{bx}{sc}{17.28}{20}%{20.74}{25}%
\SetTBFont{ThesisPresented}%
{\TitlePageFontEncoding}{\TitlePageFontFamily}{m}{n}{12}{15}%{14}{15}%
\SetTBFont{ThesisBefore}%
{\TitlePageFontEncoding}{\TitlePageFontFamily}{bx}{n}{17.28}{20}%{20.74}{25}%
\SetTBFont{ThesisUFR}%
{\TitlePageFontEncoding}{\TitlePageFontFamily}{m}{sc}{12}{15}%{20.74}{25}%
\SetTBFont{ThesisPresentedThe}%
{\TitlePageFontEncoding}{\TitlePageFontFamily}{m}{n}{12}{15}%{14}{15}%
\SetTBFont{ThesisInOrderToGet}%
{\TitlePageFontEncoding}{\TitlePageFontFamily}{m}{n}{12}{15}%{14}{15}%
\SetTBFont{ThesisDiploma}%
{\TitlePageFontEncoding}{\TitlePageFontFamily}{m}{sc}{12}{15}%{14}{15}%{17.28}{20}
\SetTBFont{ThesisUniv}%
{\TitlePageFontEncoding}{\TitlePageFontFamily}{m}{n}{12}{15}%{14}{15}%{17.28}{20}
\SetTBFont{ThesisDelivered}%
{\TitlePageFontEncoding}{\TitlePageFontFamily}{m}{sc}{12}{15}%{20.74}{25}%
\SetTBFont{ThesisMention}%
{\TitlePageFontEncoding}{\TitlePageFontFamily}{m}{n}{12}{15}%{14}{15}%
\SetTBFont{ThesisPresentedBy}%
{\TitlePageFontEncoding}{\TitlePageFontFamily}{m}{n}{12}{15}%{14}{15}%
\SetTBFont{ThesisAuthorFirstName}%
{\TitlePageFontEncoding}{\TitlePageFontFamily}{bx}{sc}{17.28}{20}
\SetTBFont{ThesisAuthorLastName}%
{\TitlePageFontEncoding}{\TitlePageFontFamily}{bx}{sc}{17.28}{20}
\SetTBFont{ThesisSupervisorFirstName}%
{\TitlePageFontEncoding}{\TitlePageFontFamily}{bx}{sc}{17.28}{20}
\SetTBFont{ThesisSupervisorLastName}%
{\TitlePageFontEncoding}{\TitlePageFontFamily}{bx}{sc}{17.28}{20}
\SetTBFont{ThesisJury}%
{\TitlePageFontEncoding}{\TitlePageFontFamily}{m}{n}{12}{15}%{14}{15}%
\SetTBFont{ThesisAffil}%
{\TitlePageFontEncoding}{\TitlePageFontFamily}{m}{n}{12}{15}%{14}{15}%{12}{14}
\SetTBFont{ThesisAffilSmall}%
{\TitlePageFontEncoding}{\TitlePageFontFamily}{m}{n}{12}{15}%{14}{15}%{14}{17}
\SetTBFont{ThesisCompositionJury}%
{\TitlePageFontEncoding}{\TitlePageFontFamily}{m}{n}{12}{15}%{14}{15}%

\newif\if@affiliation
\@affiliationfalse
\newtoks\@affil@tokI
\newtoks\@affil@tokII
\newcommand\@tokc@t[3]{%
  \edef\@tokconc@t{\the#1\the#2}%
  #3=\expandafter{\@tokconc@t}%
  }
\newtoks\@thesis@affil
\newcommand{\NewAffilCategory}[3]{%
  \expandafter\newtoks\csname#1\endcsname
  \csname#1\endcsname={}%
  \expandafter\def\csname#1@title\endcsname{{#2}{#3}}%
  \@affil@tokI=\expandafter{\csname#1\endcsname}%
  \@tokc@t\@thesis@affil\@affil@tokI\@thesis@affil
  \@affil@tokI=\expandafter{\csname#1@title\endcsname}%
  \@tokc@t\@thesis@affil\@affil@tokI\@thesis@affil
  }
\newcommand{\ClearAffil}{\@thesis@affil={}}
\ClearAffil
\NewAffilCategory{EcoleDoctorale}{\textit{Doctoral school:}}{Doctoral school:}
\NewAffilCategory{EcolesDoctorales}{\textit{Doctoral schools:}}{Doctoral schools:}
\NewAffilCategory{LaboratoireAcceuil}{\textit{Laboratory:}}{Laboratory:}
\NewAffilCategory{EquipeAccueil}{\textit{\raggedright Team:}}{\raggedright Team:}
\NewAffilCategory{EquipesAccueil}{\textit{Teams~:}}{Teams~:}

\def\@selectiaffil#1{\expandafter\@@selectiaffil#1}
\def\@@selectiaffil#1#2{{#1}}
\def\@selectiiaffil#1{\expandafter\@@selectiiaffil#1}
\def\@@selectiiaffil#1#2{{#2}}
\newcommand\@buildaffil[1]{%
  \@affil@tokI={\bgroup\UseEntryFont{ThesisAffil}\begin{tabular}{rll}}%
    \expandafter\@@buildaffil\the#1/%
    \@affil@tokII={\end{tabular}\egroup}%
  \@tokc@t\@affil@tokI\@affil@tokII\@affil@tokI
  \the\@affil@tokI
  }
\def\@@buildaffil#1#2#3/{%
  \def\@tmpa{#3}%
  \ifx\@tmpa\@empty
  \def\@tmpa{#1}%
  \ifx\@tmpa\@empty
  \else\@buildentryaffil#1#2%
  \fi
  \else
  \@buildentryaffil#1#2%
  \@@buildaffil#3/%
  \fi
  }
\newcommand\@buildentryaffil[2]{\expandafter\@buildtableaffil\the#1\\/#2}
\def\@buildtableaffil#1\\#2/#3{%
  \def\@tmpa{#1}%
  \ifx\@tmpa\@empty
  \else
  \@affiliationtrue %cette variable est utilisée pour supprimer un
                    % \vfill lorsqu'il n'y a pas d'affiliation de 
                    % précisée
  \def\@tmpa{#2}%
  \ifx\@tmpa\@empty
  \@affil@tokII={\@selectiaffil#3&#1\\}%
  \@tokc@t\@affil@tokI\@affil@tokII\@affil@tokI
  \else
  \@affil@tokII={\@selectiiaffil#3&#1\\}%
  \@tokc@t\@affil@tokI\@affil@tokII\@affil@tokI
  \@@buildtableaffil#2/%
  \fi
  \@affil@tokII={[1mm]}%
  \@tokc@t\@affil@tokI\@affil@tokII\@affil@tokI
  \fi
  }
\def\@@buildtableaffil#1\\#2/{%
  \@affil@tokII={&#1\\}%
  \@tokc@t\@affil@tokI\@affil@tokII\@affil@tokI
  \def\@tmpa{#2}%
  \ifx\@tmpa\@empty
  \else\@@buildtableaffil#2/%
  \fi
  }

\newcommand\@ThesisAffil{
  \if@style@edit
  \vspace{0.75cm}\it\@buildaffil\@thesis@affil
  \else
  \UseEntryFont{ThesisAffil}\fbox{utiliser \tt\char`\\ThesisAffil\{Work realized within...\}}
  \fi
}
\newcommand\ThesisAffil[1]%
{\@affiliationfalse \ClearAffil \renewcommand{\@ThesisAffil}{{\UseEntryFont{ThesisAffil}#1\par}}}


\newtoks\@jury@tokI
\newtoks\@jury@tokII
\newtoks\@thesis@jury
\newcommand{\NewJuryCategory}[3]{%
  \expandafter\newtoks\csname#1\endcsname
  \csname#1\endcsname={}%
  \expandafter\def\csname#1@title\endcsname{{#2}{#3}}%
  \@jury@tokI=\expandafter{\csname#1\endcsname}%
  \@tokc@t\@thesis@jury\@jury@tokI\@thesis@jury
  \@jury@tokI=\expandafter{\csname#1@title\endcsname}%
  \@tokc@t\@thesis@jury\@jury@tokI\@thesis@jury
  }
\newcommand{\ClearJury}{\@thesis@jury={}}
\ClearJury
\NewJuryCategory{Vide}{\textit{}}{\textit{}}
\NewJuryCategory{President}{\textit{President}}{\textit{Presidents}}
\NewJuryCategory{Rapporteurs}{\textit{Reporter}}{\textit{Reviewers}}
\NewJuryCategory{Examinateurs}{\textit{Examinator}}{\textit{Examinators}}
\NewJuryCategory{Invites}{\textit{Invit\'e}}{\textit{Invit\'es}}
\def\@selecti#1{\expandafter\@@selecti#1}
\def\@@selecti#1#2{{#1}}
\def\@selectii#1{\expandafter\@@selectii#1}
\def\@@selectii#1#2{{#2}}
\newcommand\@buildjury[1]{%
  \@jury@tokI={\bgroup\UseEntryFont{ThesisJury}\begin{tabular}{lrr}}%
    \expandafter\@@buildjury\the#1/%
    \@jury@tokII={\end{tabular}\egroup}%
  \@tokc@t\@jury@tokI\@jury@tokII\@jury@tokI
  \the\@jury@tokI
  }
\def\@@buildjury#1#2#3/{%
  \def\@tmpa{#3}%
  \ifx\@tmpa\@empty
  \def\@tmpa{#1}%
  \ifx\@tmpa\@empty
  \else\@buildentry#1#2%
  \fi
  \else
  \@buildentry#1#2%
  \@@buildjury#3/%
  \fi
  }
\newcommand\@buildentry[2]{\expandafter\@buildtable\the#1\\/#2}
\def\@buildtable#1\\#2/#3{%
  \def\@tmpa{#1}%
  \ifx\@tmpa\@empty
  \else
  \def\@tmpa{#2}%
  \ifx\@tmpa\@empty
  \@jury@tokII={\@selecti#3&#1\\}%
  \@tokc@t\@jury@tokI\@jury@tokII\@jury@tokI
  \else
  \@jury@tokII={\@selectii#3&#1\\}%
  \@tokc@t\@jury@tokI\@jury@tokII\@jury@tokI
  \@@buildtable#2/%
  \fi
  \@jury@tokII={[3mm]}%
  \@tokc@t\@jury@tokI\@jury@tokII\@jury@tokI
  \fi
  }
\def\@@buildtable#1\\#2/{%
  \@jury@tokII={&#1\\}%
  \@tokc@t\@jury@tokI\@jury@tokII\@jury@tokI
  \def\@tmpa{#2}%
  \ifx\@tmpa\@empty
  \else\@@buildtable#2/%
  \fi
  }
\newcommand\@ThesisJury{\@buildjury\@thesis@jury}

\newlength\@bindingshift
\setlength\@bindingshift{0pt}
\newcommand\SetBinding[1]{%
  \setlength\@bindingshift{#1}%
  \divide\@bindingshift2\relax
  }
\newlength\@htitlepageshift
\newcommand{\@cover@hook}{}
\newenvironment{changemargin}[2]{\begin{list}{}{%
\setlength{\topsep}{0pt}%
\setlength{\leftmargin}{0pt}%
\setlength{\rightmargin}{0pt}%
\setlength{\listparindent}{\parindent}%
\setlength{\itemindent}{\parindent}%
\setlength{\parsep}{0pt plus 1pt}%
\addtolength{\leftmargin}{#1}%
\addtolength{\rightmargin}{#2}%
}\item }{\end{list}}

\newcommand{\MakeThesisTitlePage}%
{%
  \newpage
  \@cover@hook
  \thispagestyle{empty}
 \begin{changemargin}{-0.7cm}{-0.5cm}
    \@thesis@titlep@gebody
  \end{changemargin}
  \newpage  
  \if@twoside
  \thispagestyle{empty}
  \hbox{}
  \par\vfill
  \newpage
  \addtocounter{page}{-2}%
  \else
  \addtocounter{page}{-1}%
  \fi
  \fontencoding{OT1}\normalfont\selectfont
  }%
\newcommand\@thesis@titlep@gebody{%
 %---------------------------------------------------
  \if@doubleinterligne\renewcommand\baselinestretch{1.0}\fi
  %\vspace*{2cm} 
  %
  %POUR DECALER VERS LE BAS LA PAGE DE TITRE%
  \vspace*{-1.5cm}
  \@ThesisNumeroOrdre
  \begin{center}
    \@ThesisKind
    \vfill
    \@ThesisPresented
    \vfill
    \@ThesisBefore
    \vfill
    \@ThesisUFR
    \vfill
    \@ThesisInOrderToGet \@ThesisDiploma
     \vfill
    \@ThesisUniv
    \vfill
     \@ThesisDelivered
    \vfill
    \@ThesisMention
    \vfill
    \@ThesisPresentedBy
    \vfill
    \UseEntryFont{ThesisAuthorFirstName}\@ThesisAuthorFirstName\normalfont\selectfont
    \space 
    \UseEntryFont{ThesisAuthorLastName}\@ThesisAuthorLastName\normalfont\selectfont
    \vfill
  \end{center} 
  \if@style@edit
      \begin{center}
       \@ThesisAffil
      \end{center}
      \if@affiliation
      \vfill
      \fi
    \fi
    \vspace*{0.5cm}
  \begin{center}
    \center{\rule[1pt]{\linewidth}{1pt}\\}
    \UseEntryFont{ThesisTitle}
   % \begin{tabular*}{17.5}[c]{1}
%     \hline \\
     \sf\textbf{\@ThesisTitle}\normalfont\selectfont
    % \hline\end{tabular*}
    \vspace{-0.5cm}
    \center{\rule[1pt]{\linewidth}{1pt}\\}
    %\vspace{0.5cm}
    %\vfill
    
    %\@ThesisPresentedThe\\
    \vspace*{0.5cm}
    \vfill
    \@CompositionDuJury
  \end{center}
  \if@doubleinterligne
    \def\baselinestretch{1.1} %% double interligne en 11pt
    \else
    \def\baselinestretch{1.0}
  \fi
 %---------------------------------------------------
  }
  



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Defines Divers                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% les ensembles mathématiques
\RequirePackage{bbm}
\def\N{\ensuremath{\mathbbm{N}}}
\def\R{\ensuremath{\mathbbm{R}}}
\def\Z{\ensuremath{\mathbbm{Z}}}

\def\Q{\ensuremath{\mathbbm{Q}}}
\def\C{\ensuremath{\mathbbm{C}}}
\def\F{\ensuremath{\mathbbm{F}}}
\def\K{\ensuremath{\mathbbm{K}}}

% le \fixme est pratique pour marquer les endroits � 
% corriger ultérieurement dans la thèse (écrit en gras
% on le trouve facilement sur le papier, et par ailleurs
% ou avec la commande unix :
% find . -name \*.tex -exec grep '\\fixme' {} \; -print
\def\fixme{{\bf FIXME: }}

\def\cad{\mbox{c.-� -d.}}
\def\cf{{cf.}}
\def\ie{{\it i.e.}}


%------ quelques commandes de formatage de pages / paragraphes ------
\newcommand{\DS}[1]{\displaystyle{#1}}
\newcommand{\bsloppy}{\begin{sloppypar}}
\newcommand{\esloppy}{\end{sloppypar}}
\newcommand{\msaut}{\vspace*{-0.1cm}}
\newcommand{\gsaut}{\vspace*{1.cm}}
\newcommand{\saut}{\vspace*{.5cm}}
\newcommand{\psaut}{\vspace*{.2cm}}
\newcommand{\ppsaut}{\vspace*{.1cm}}
\newcommand{\malinea}{\hspace*{-2cm}}
\newcommand{\alinea}{\hspace*{2cm}}
\newcommand{\palinea}{\hspace*{1cm}}
\newcommand{\ppalinea}{\hspace*{0.5cm}}
\newcommand{\psalinea}{\hspace*{0.2cm}}
\newcommand{\build}[3]{\mathrel{\mathop{\kern 0pt#1}\limits_{#2}^{#3}}}
\newcommand{\Accolade}[1]{\left\{\begin{array}{l} #1 \end{array}\right. }
\newcommand{\Entrepar}[1]{\left( \begin{array}{c}\hspace*{-0.2cm} #1
\hspace*{-0.2cm}\end{array}\right) }
\newcommand{\Entreacc}[1]{\left\{ \begin{array}{c}\hspace*{-0.2cm} #1
      \hspace*{-0.2cm}\end{array}\right\} }

%-------------- quelques "shortcuts" pratiques ...  ----------------
% \renewcommand{\cf}{{\sl cf.~}}
\newcommand{\cffig}[1]{(\cf~figure~\ref{#1})}
\newcommand{\cfequ}[1]{(\cf~quation~\eqref{#1})}
\newcommand{\cfpar}[1]{(\cf~paragraphe~\ref{#1})}
\newcommand{\etc}{{etc.}}

%--------- pour les citations ( la place de \citation) ------------
\newcommand{\citat}[2]{
\begin{tabular}{p{5.5cm}p{9cm}}
 & \og {\small  {\sl #1}} \fg\\
 &\vspace*{0.5mm} {\scriptsize #2} 
\end{tabular} } 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  PAGE LAYOUT                                   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\topmargin 0mm
\headheight 10mm
\headsep 10mm
\footskip 10mm
\columnsep 6mm
\columnseprule 0pt

\sloppy
\parindent 2.5cm
\leftmargini 2em
\leftmargin\leftmargini
\leftmarginv .5em
\leftmarginvi .5em

\if@twoside
\setlength{\oddsidemargin}{0cm}
\setlength{\evensidemargin}{0cm} 
\else
\oddsidemargin  0.0cm  
\evensidemargin 0.0cm  
\fi

\marginparwidth 1.5cm   %   Width of marginal notes.
\textwidth      15.5cm  
\voffset        -1.0cm  % Decalage vertical vers le haut
\textheight     23.5cm


% on détermine le nombre de flottants autorisés par page,
\setcounter{totalnumber}{6} 
\renewcommand{\floatpagefraction}{.7}
\renewcommand{\topfraction}{1.0}
\renewcommand{\bottomfraction}{1.0}
\renewcommand{\textfraction}{0.00}


\setlength{\parindent}{0.6cm} % indent au debut d'un paragraph
\setlength{\parskip}{1.5mm}   % distance entre paragraphes

\if@doubleinterligne
\def\baselinestretch{1.1} %% double interligne en 11pt
\else
\def\baselinestretch{1.0}
\fi


% The `\flushbottom' declaration makes all text pages the same height,
% adding extra vertical space when necessary to fill out the page.
%    This is the standard if twocolumn mode is selected.
\flushbottom

% on commence en chiffres romains jusqu'a \mainmatter
\pagenumbering{roman} 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FancyHeadings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\blob}{\setlength{\unitlength}{30mm}
	\begin{picture}(0,0)
		\colorbox{black}{
			\makebox(0.4, 0.4)[c]{\textcolor{white}{\large\thechapter}}}
	\end{picture}}
	
	%\rule[-0.4\unitlength]{0.4\unitlength}{0.4\unitlength}}

\newcommand\rblob{\setlength{\unitlength}{30mm}
	\begin{picture}(0,0)
	\put(0.43,-\value{chapter}){\blob}
	\end{picture}}
	
\newcommand\lblob{%
	\setlength{\unitlength}{30mm}
	\begin{picture}(0,0)
	\put(-0.88,-\value{chapter}){\blob}
	\end{picture}%
	\leftmark
}


\RequirePackage{doublebox}
\RequirePackage{color}
\definecolor{gris25}{gray}{0.75}

%\RequirePackage{fancyhdr}
\chead{}

\fancypagestyle{mystyle}{
\if@twoside
\fancyhf{} % clear all fields
\fancyhead[LE]{\nouppercase{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\small\selectfont\lblob}}
\fancyhead[RO]{\nouppercase{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\small\selectfont\rightmark\rblob}}
\fancyfoot[LE,RO]{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\selectfont\small\thepage}
\fancyfoot[RE]{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\selectfont\small\@ThesisAbbrv}
\fancyfoot[LO]{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\selectfont\small\@ThesisAbbrv}
\else
\fancyhf{} % clear all fields
\fancyhead[RO]{\nouppercase{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\small\selectfont\rblob}}
%\fancyhead[RO]{\nouppercase{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\small\selectfont\rightmark}}
\fancyfoot[RO]{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\small\selectfont\thepage}
\fancyfoot[LO]{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\small\selectfont\@ThesisAbbrv}

\fi

\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}}

\fancypagestyle{mystyle3}{
\if@twoside
\fancyhf{} % clear all fields
\fancyhead[LE]{\nouppercase{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\small\selectfont\leftmark}}
\fancyhead[RO]{\nouppercase{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\small\selectfont\leftmark}}
\fancyfoot[LE,RO]{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\selectfont\small\thepage}
\fancyfoot[RE]{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\selectfont\small\@ThesisAbbrv}
\fancyfoot[LO]{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\selectfont\small\@ThesisAbbrv}
\else
\fancyhf{} % clear all fields
\fancyhead[RO]{\nouppercase{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\small\selectfont}}
%\fancyhead[RO]{\nouppercase{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\small\selectfont\rightmark}}
\fancyfoot[RO]{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\small\selectfont\thepage}
\fancyfoot[LO]{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\small\selectfont\@ThesisAbbrv}

\fi

\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}
}



\fancypagestyle{mystyle2}{
  \fboxrule=1\fboxrule
  \let\oldhrule=\hrule
  \let\oldvrule=\vrule
  \def\rulethickness{\afterassignment
  \dorulethickness\dimen0 }
  \def\dorulethickness{\edef\hrule
  {\oldhrule height\dimen0 }%
  \edef\vrule
  {\oldvrule width\dimen0 }}

  \if@twoside
    \fancyhf{} % clear all fields
    \fancyhead[LE]{\rulethickness=\fboxrule\nouppercase{\fontfamily{\sfdefault}\fontseries{b}\fontshape{sf}\small\selectfont%
      \fbox{\colorbox{black}{\textcolor{white}{\leftmark}}}}\hrulefill}
    \fancyhead[LO]{\rulethickness=\fboxrule\hrulefill\nouppercase{\fontfamily{\sfdefault}\fontseries{b}\fontshape{sf}\small\selectfont%
      \fbox{\colorbox{black}{\textcolor{white}{\rightmark}}}}}
    \fancyfoot[LE]{\rulethickness=\fboxrule\fontfamily{\sfdefault}\fontseries{b}\fontshape{sf}\selectfont\small\fbox{\colorbox{black}{\textcolor{white}{\thepage}}}\hrulefill}
    \fancyfoot[LO]{\rulethickness=\fboxrule\fontfamily{\sfdefault}\fontseries{b}\fontshape{sf}\selectfont\small\hrulefill\fbox{\colorbox{black}{\textcolor{white}{\thepage}}}}
  \else
    \fancyhf{} % clear all fields
    \fancyhead[LO]{\rulethickness=\fboxrule\hrulefill\nouppercase{\fontfamily{\sfdefault}\fontseries{b}\fontshape{sf}\small\selectfont%
      \fbox{\colorbox{black}{\textcolor{white}{\leftmark}}}}\hrulefill}
    %\fancyhead[RO]{\nouppercase{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\small\selectfont\rightmark}}
    \fancyfoot[LO]{\rulethickness=\fboxrule\fontfamily{\sfdefault}\fontseries{b}\fontshape{sf}\selectfont\small\hrulefill\fbox{\colorbox{black}{\textcolor{white}{\thepage}}}\hrulefill}
  \fi
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0.4pt}
}
%
\fancypagestyle{plain}{
\if@style@shadow
\renewcommand{\headrulewidth}{0.0pt}
\renewcommand{\footrulewidth}{0.0pt}
\fancyhf{} % clear all fields
\else
\if@twoside
\renewcommand{\headrulewidth}{0.0pt}
\renewcommand{\footrulewidth}{0.0pt}
\fancyhf{} % clear all fields
\fancyfoot[LE,RO]{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\small\selectfont\thepage}
\fancyfoot[RE]{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\small\selectfont\@ThesisAuthorFirstName\space\@ThesisAuthorLastName}
\fancyfoot[LO]{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\small\selectfont\@ThesisAbbrv}
\else
\renewcommand{\headrulewidth}{0.0pt}
  \renewcommand{\footrulewidth}{0.0pt}
\fancyhf{} % clear all fields
\fancyfoot[RO]{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\small\selectfont\thepage}
\fancyfoot[LO]{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\small\selectfont\@ThesisAuthorFirstName\space\@ThesisAuthorLastName}
\fancyfoot[LO]{\fontfamily{\sfdefault}\fontseries{m}\fontshape{sf}\small\selectfont\@ThesisAbbrv}
\fi
\fi
}

\if@style@shadow
\pagestyle{mystyle2}  
\else
\pagestyle{mystyle}
\fi

\renewcommand{\chaptermark}[1]{%
{\markboth{#1}{}}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Style french                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%\RequirePackage[frenchb]{babel}
%%\RequirePackage{french}
%
%\frenchspacing
%\def\acknowledgmentsname{Remerciements}
%\def\introductionname{Introduction}
%\def\conclusionname{Conclusion}
%\def\myabstractname{Abstract}
%\def\resumename{Résumé}
%\addto\captionsfrench{\def\pagename{page}}
%\addto\captionsfrench{\def\refname{Références}}
%\addto\captionsfrench{\def\bibname{Bibliographie}}
%\addto\captionsfrench{\def\listfigurename{Liste des figures}}
%\addto\captionsfrench{\def\listtablename{Liste des tableaux}}
%\addto\captionsfrench{\def\indexname{Index}}
%\addto\captionsfrench{\def\seename{\emph{voir}}}
%\addto\captionsfrench{\def\seealsoname{\emph{voir aussi}}}
%\addto\captionsfrench{\def\figurename{Figure}}
%\addto\captionsfrench{\def\tablename{Tableau}}
%\addto\captionsfrench{\def\partname{\protect\@RPt partie}}
%\addto\captionsfrench{\def\@RPt{{\ifcase\value{part}\or Premi\`ere\or Deuxi\`eme\or 
%      Troisi\`eme\or Quatri\`eme\or Cinqui\`eme\or Sixi\`eme\or 
%      Septi\`eme\or Huiti\`eme\or Neuvi\`eme\or Dixi\`eme\or 
%      Onzi\`eme\or Douzi\`eme\or Treizi\`eme\or Quatorzi\`eme\or 
%      Quinzi\`eme\or Seizi\`eme\or Dix-septi\`eme\or
%      Dix-huiti\`eme\or Dix-neuvi\`eme\or Vingti\`eme\fi}\space\def\thepart{}}}
%
%\addto\captionsfrench{\def\glossaryname{\sf Glossaire}}
%\addto\captionsfrench{\def\chaptername{Chapitre}}
%\addto\captionsfrench{\def\appendixname{Annexe}}
%\addto\captionsfrench{\def\appendixtitle{Annexe du chapitre}}
%\ifx\ier\undefined\def\ier{er}\fi
%\addto\captionsfrench{\def\today{\ifnum\day=1\relax 1\ier
%    \else \number\day\fi
%    \space\ifcase\month\or janvier\or f\'evrier\or mars\or 
%    avril\or mai\or juin\or juillet\or ao\^ut\or septembre\or 
%    octobre\or novembre\or d\'ecembre\fi \space\number\year}}
%
%%\renewcommand\abstractname{R\'esum\'e}
%\def\note#1{\footnote{---~#1}}
%
%\def\L#1{\ensuremath{{\cal {L}}^{#1}}}
%\def\Linf{\ensuremath{{\cal {L}}^{\infty}\,}}
%%\def\degre{\ensuremath{{}^{\circ}}}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Chapitre                                      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{titlesec}
\renewcommand\cleardoublepage{%
% On desire, dans le cas du recto-verso, si la page de
% gauche n'a pas de texte, d'enlever le style 
% (le haut et le bas de la page) 
\clearpage
\if@twoside
  \ifodd\c@page
  \else
    \hbox{}\thispagestyle{empty}\newpage
  \fi
\fi 
}

\if@style@chapOne
\newfont{\chapfonte}{pplr scaled 7000} %%%%%%%%%%%%%cmr10 scaled 7000}
\RequirePackage{titlesec}
\titleformat{\chapter}[display]
{\bfseries\filinner\Large\sffamily}
{\huge\space\sffamily\chaptertitlename\space \chapfonte\thechapter}
{1pc}
{\Large\selectfont\titlerule[2pt]%
\vspace{2pt}%
\titlerule%
\vspace{1pc}
\Huge}
[\Large\selectfont\vspace{1pc}\titlerule\vspace{2pt}{\titlerule[2pt]}]
\fi

\if@style@chapTwo
\def\@Fch{{\ifcase\value{chapter}\or Premier\or Deuxi\`eme\or
      Troisi\`eme\or Quatri\`eme\or Cinqui\`eme\or Sixi\`eme\or
      Septi\`eme\or Huiti\`eme\or Neuvi\`eme\or Dixi\`eme\or Onzi\`eme\or
      Douzi\`eme\or Treizi\`eme\or Quatorzi\`eme\or Quinzi\`eme\or
      Seizi\`eme\or Dix-septi\`eme\or Dix-huiti\`eme\or Dix-neuvi\`eme\or
      Vingti\`eme\fi}\space\def\thechapter{}}


\titleformat{\chapter}[display]
{\bfseries\filinner\Large\sffamily}
{\huge\@Fch\chaptername\vspace{12pt}}
{1pc}
{\vspace{2pt}
\titlerule
\Huge}
[]
\fi

\if@style@chapThree
  \RequirePackage{ifthen}
  \renewcommand\chaptername{chapitre}
  \newfont{\chapfonte}{pplr scaled 9000}%putr8r scaled 9000}
                                % La taille (=hauteur) de la fonte est 10pt * scaled / 1000
                                % Remarque : \magstep<n> vaut 1000*(1.2)^n
                                % Donc \magstep1 multiplie la fonte par 1.2, ie l'augmente de 20%

  \def\haut{20mm}         % Hauteur des chiffres, �  ajuster avec 'scaled'
  \def\decal{1.75ex}      % Pour aligner la ligne avec le haut de CHAPITRE

  \newlength{\lgnamechap}
  \newlength{\lgnumchap}
  \newlength{\lgall}
  \def\@makechapterhead#1{%
    \vskip 10\p@
    \def\myboxtwo{\mbox{\chapfonte\thechapter}}
      
    %\ifthenelse{\equal{\@chapapp}{\chaptername}}%
    %{\def\myboxone{\large\sf\uppercase\expandafter{\chaptername}}}%
    %{\def\myboxone{\large\sf\uppercase\expandafter{\appendixname}}}
    
    %\settowidth{\lgnamechap}{\myboxone}
    \settowidth{\lgnumchap}{\myboxtwo}
    \addtolength{\lgnumchap}{6mm}
    \setlength{\lgall}{\textwidth}
    %\addtolength{\lgall}{-\lgnamechap}
    \addtolength{\lgall}{-\lgnumchap}
    \addtolength{\lgall}{-5pt}
    {\parindent\z@
      %\parbox[t]{\lgnamechap}{\myboxone}
      \raisebox{\decal}{%
        \raisebox{-\haut}{\parbox[t]{\lgnumchap}{\hspace{2mm}\myboxtwo}}}
      \raisebox{\decal}{\parbox[t]{\lgall}{\rule{\lgall}{1mm}
          \begin{flushleft}
            \renewcommand\baselinestretch{1.0}
            \Huge\sf\textbf{#1}
            \renewcommand\baselinestretch{1.1}
          \end{flushleft}
          }}
      \par
      \nobreak
      \vskip 100\p@
      }
    }

\def\@makeschapterhead#1{%
  \def\myboxtwo{\mbox{\chapfonte 1}}
  %\def\myboxone{\Large\sf\uppercase\expandafter{chapitre}}
  %\settowidth{\lgnamechap}{\myboxone}
  \settowidth{\lgnumchap}{\myboxtwo}
  \addtolength{\lgnumchap}{6mm}
  \setlength{\lgall}{\textwidth}
  %\addtolength{\lgall}{-\lgnamechap}
  \addtolength{\lgall}{-\lgnumchap}
  \addtolength{\lgall}{-5pt}
  {
    \typeout{----------> }
    \typeout{----------> \@chapapp\space #1.}
    \typeout{----------> }
    \parindent\z@
    %\parbox[t]{\lgnamechap}{\hspace{\lgnamechap}}
    \raisebox{\decal}{%
      \raisebox{-\haut}{\parbox[t]{\lgnumchap}{\hspace{2mm}\hspace{\lgnumchap}}}}
    \raisebox{\decal}{\parbox[t]{\lgall}{\rule{\lgall}{1mm}          
        \begin{flushleft}
          \Huge\sf\textbf{#1}
        \end{flushleft}
        }}
    \par
    \nobreak
    \vskip 100\p@
    }
   \def\myname{#1}
   \def\mymajname{\MakeUppercase{\myname}}
   \markboth{\mymajname}{\mymajname}
  }
\fi 

% fin de la definition du style ChapitreThree (Style3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Part                                          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\titleformat{\part}[display]
{\bfseries\filinner\Huge\sffamily}
{\it\huge\@ThesisTitle}
{1pc}%1pc}
{%\vspace{-12pt}
\rule{\textwidth}{2pt}
}
[]



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% caption %%% ATTENTION CE N'est PAS forcement supporté par toutes les
% distrib LateX 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{caption2}

%\captionstyle{centerlast}
\renewcommand\captionfont{\footnotesize}
\renewcommand\captionlabelfont{\bfseries\itshape}
%\setcaptionmargin{\leftmargini}
\setlength\captionindent{\parindent}
\renewcommand\captionlabeldelim{~---}
\onelinecaptionstrue
\setcaptionwidth{0.8\textwidth}%12.9999cm}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algorithmes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\RequirePackage[lined,algoruled,algochapter,titlenumbered,commentsnumbered,linesnumbered]{algorithm2e}
%\renewcommand{\algocf@captiontext}[2]{\captionfont{\captionlabelfont #1}\algocf@typo\captionlabeldelim~ #2} % text of caption
%\SetAlFnt{\footnotesize}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% varioref
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{varioref}

\def\reftextfaceafter {\`a la page \reftextvario{ci-contre}{suivante}}
\def\reftextfacebefore{\`a la page \reftextvario{pr\'ec\'edente}{ci-contre}}
\def\reftextafter     {\`a la page suivante}
\def\reftextbefore    {\`a la page pr\'ec\'edente}
\def\reftextcurrent   {de la pr\'esente page}
\def\reftextfaraway#1{page~\pageref{#1}}

\vrefwarning



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Remerciements, Résumé, Abstract, Intro, Conclu, Biblio %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\Remerciements}[1]{%
  \chapter*{ #1}
  \addcontentsline{toc}{chapter}{#1}
}
\newcommand{\Abreviation}[1]{%
  \chapter*{ #1}
  \addcontentsline{toc}{chapter}{#1}
  \pagestyle{mystyle3}
}
\newcommand{\Introduction}[1]{%
  \chapter*{ #1}
  \addcontentsline{toc}{chapter}{#1}
}
\newcommand{\Conclusion}[1]{%
  \chapter*{ #1}
  \addcontentsline{toc}{chapter}{#1}
  \pagestyle{mystyle3}
}


\newcommand{\Abstract}[1]{%
  \chapter*{ #1}
  \addcontentsline{toc}{chapter}{#1}
}
\newcommand{\Resume}[1]{%
  \chapter*{ #1}
  \addcontentsline{toc}{chapter}{#1}
}
\newcommand{\Notations}[1]{%
  \chapter*{#1}
  \addcontentsline{toc}{chapter}{#1}
}

\newcommand{\ListeFigures}[1]{%
  \cleardoublepage
  \addcontentsline{toc}{chapter}{#1}
  \listoffigures
  \pagestyle{mystyle3}
}
\newcommand{\ListeTables}[1]{%
  \cleardoublepage
  \addcontentsline{toc}{chapter}{#1}
  \listoftables
}

\newcommand{\Bibliographie}[1]{%
  \cleardoublepage
  \addcontentsline{toc}{chapter}{\bibname}
  \bibliography{#1}
   \pagestyle{mystyle}
}

\newcommand{\Partie}[1]{%
  \part{#1}
}

\newcommand{\Sommaire}{%
  \setcounter{secnumdepth}{3}%
  \setcounter{tocdepth}{3}%
  \clearpage
 \pagestyle{mystyle3}
  \def\baselinestretch{0.5}
  \tableofcontents
  
  % La commande \mainmatter (nouvelle commande LaTeX2e) permet de passer
  % a la numérotation arabe (ce que fait \pagenumbering{arabic})
  % et de faire commencer la nouvelle page 1 sur une page impaire.
  % On évitera donc d'utiliser directement \pagenumbering{arabic}.
  \mainmatter
  \if@doubleinterligne
    \def\baselinestretch{1.1} %% double interligne en 11pt
    \else
    \def\baselinestretch{1.0}
  \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  ChapterAbstract                               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@chapterabstract@hook}{}
\newenvironment{ChapterAbstract}%
{%
  \@chapterabstract@hook
  \vspace*{\stretch{1}} 
  }
{% 
  \vspace*{\stretch{2}}
  \newpage
  }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Listes                                        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{stmaryrd}
\renewcommand{\labelitemi}{$\rightslice$}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Page de Signatures                            %%
%%  paramètres : Nom de l'université,             %%
%%               Président de l'université        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\PageSignatures}[2]{%
  % exemple (RennesI) : 
  % \PageSignatures{l'Université de Rennes~I}{Patrick NAVATTE}
  \cleardoublepage
  \thispagestyle{empty}
  {
    \Large
    \vspace*{-2cm}
    \hspace{-2.5cm}
    \begin{minipage}[t]{0.5\textwidth}
      \begin{center}
        VU~:\\[2cm]
        Le Directeur de Th\`ese      
      \end{center} 
    \end{minipage}%
    \hspace{2cm}
    \begin{minipage}[t]{0.5\textwidth}
      \begin{center}
        VU~:\\[2cm]
        \mbox{Le Responsable de l'\'Ecole Doctorale}
      \end{center}
    \end{minipage}


    \vspace*{\stretch{2}}
    \begin{center}
      \begin{minipage}[t]{0.8\textwidth}    
        VU pour autorisation de soutenance\\[0.5cm]
        Toulouse, le\\[0.5cm]
        Le Président de #1
      \end{minipage}
      
      \vspace*{\stretch{1}}

      #2

      \vspace*{\stretch{3}}

      \begin{minipage}[t]{0.8\textwidth}    
        VU après soutenance pour autorisation de publication~:\\[0.5cm]
        Le Président de Jury,
      \end{minipage}
    \end{center}  
    \vspace*{\stretch{2}}
    }
  }
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  ThesisDedication                              %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@dedication@hook}{}
\newenvironment{ThesisDedication}{%
  \cleardoublepage
  \@dedication@hook
  \@mkboth{}{}
  \thispagestyle{empty}
  \vglue0pt plus.5fil
  \fontfamily{\sfdefault}\fontseries{m}\fontshape{sl}\selectfont
  \begin{flushright}
    }%
  {%
  \end{flushright}
  \vglue0pt plus1fil\cleardoublepage
  }




\endinput
