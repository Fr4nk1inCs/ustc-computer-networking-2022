\NeedsTeXFormat{LaTeX2e}
\LoadClassWithOptions{article}
\ProvidesClass{homework}[2014/12/16 Class file for homework assignments]

% ----- Options ---------------------------------------------------------------
\newcommand\@opanon{0}
\DeclareOption{anonymous}{\renewcommand\@opanon{1}}
\newcommand\@opnewpage{0}
\DeclareOption{newpage}{\renewcommand\@opnewpage{1}}
\newcommand\@oplargemargins{0}
\DeclareOption{largemargins}{\renewcommand\@oplargemargins{1}}
\ProcessOptions

% ----- Packages --------------------------------------------------------------

% Chinese support
\RequirePackage{ctex}

% Page settings
\RequirePackage{geometry}

% Better fonts with accents
\RequirePackage[T1]{fontenc}

% Required for starred commands
\RequirePackage{suffix}

% Math symbols
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{centernot}

% Nice lists
\RequirePackage{enumerate}
\RequirePackage{enumitem}

% Nice images, figures, and listings
\RequirePackage{graphicx}
\RequirePackage{grffile}
\RequirePackage[all]{xy}
\RequirePackage{wrapfig}
\RequirePackage{fancyvrb}
\RequirePackage{listings}

% Conditionals
\RequirePackage{ifthen}

% Header & Page Setup
\RequirePackage{fancyhdr}
\ifthenelse{\equal{\@oplargemargins}{1}}{}{\geometry{a4paper, scale = 0.8}}

% Links
\RequirePackage{hyperref}

% ----- Questions -------------------------------------------------------------
\newcounter{questionCounter}
\newcounter{partCounter}[questionCounter]
\def\questionnumber#1{
    \setcounter{questionCounter}{#1}
    \addtocounter{questionCounter}{-1}
}
% Prefix for questions
\newcommand{\questiontype}[0]{P}

% Use this if your "written" questions are all under one section
% For example, if the homework handout has Section 5: Written Questions
% and all questions are 5.1, 5.2, 5.3, etc. set this to 5
% Use for 0 no prefix. Redefine as needed per-question.
\newcommand{\writtensection}[0]{0}

% Numbered question
\providecommand{\question}{}
\renewcommand{\question}[0]{%
    % Emit \newpage if option `newpage` is present
    \ifthenelse{\equal{\@opnewpage}{1}}{%
        \newpage
    }{}

    % Wrap in minipage so that we don't get a line break enywhere in between
    \begin{minipage}{\linewidth}%
        \stepcounter{questionCounter}%
        \vspace{.2in}%
        \ifx\writtensection\undefined{}
        \noindent{\bf \questiontype\arabic{questionCounter}.}%
        \else
        \ifnum\writtensection=0
            \noindent{\bf \questiontype\arabic{questionCounter}.}%
        \else
            \noindent{\bf \questiontype\writtensection.\arabic{questionCounter}}%
        \fi
        \vspace{0.3em} \hrule \vspace{.1in}%
    \end{minipage}
}

% Named question, takes one argument
\WithSuffix\providecommand\question*{}
\WithSuffix\renewcommand\question*[1]{%
    % Emit \newpage if option `newpage` is present
    \ifthenelse{\equal{\@opnewpage}{1}}{%
        \newpage%
    }{}%
    % Wrap in minipage so that we don't get a line break enywhere in between
    \begin{minipage}{\linewidth}%
        \addtocounter{questionCounter}{1}%
        \setcounter{partCounter}{0}%
        \vspace{.2in}%
        \noindent{\bf \arabic{questionCounter}. #1}%
        \vspace{0.3em} \hrule \vspace{.1in}%
    \end{minipage}
}

% Override normal section defintions
\renewcommand{\section}[0]{\question}
\WithSuffix\newcommand\section*[1]{\question*{#1}}

% ----- Question Parts --------------------------------------------------------

\newenvironment{alphaparts}[0]{%
    \begin{enumerate}[label=\textbf{\alph{partCounter}.}, itemsep = 0em, topsep = 0em, partopsep = 0em]%
        }{\end{enumerate}}

\newenvironment{arabicparts}[0]{%
    \begin{enumerate}[label=\textbf{\arabic{questionCounter}.\arabic{partCounter}})]%
        }{\end{enumerate}}

\newcommand{\questionpart}[0]{\stepcounter{partCounter}\item}

% ----- Induction Environment -------------------------------------------------

\newenvironment{induction}[0]{%
    \begin{description}
        }{\end{description}}

\newcommand{\basecase}{\item[Base Case]\mbox{}\\}
\newcommand{\indhyp}{\item[Induction Hypothesis]\mbox{}\\}
\newcommand{\indstep}{\item[Induction Step]\mbox{}\\}

% ----- Answer Box ------------------------------------------------------------

\newcommand{\answerbox}[1]{%
    \begin{framed}
        \vspace{#1}
    \end{framed}}

% ----- Page Setup ------------------------------------------------------------

% Use block style paragraphs
\setlength{\parindent}{0pt}
\setlength{\parskip}{5pt plus 1pt}

\def\indented#1{\list{}{}\item[]}
\let\indented=\endlist

% ----- Title & Header --------------------------------------------------------
\pagestyle{empty}
\pagestyle{fancy}

%\if\@opanon%
\ifthenelse{\equal{\@opanon}{0}}{%
    \renewcommand{\maketitle}[0]{%
        % Setup header
        \setlength{\headheight}{15.2pt}
        \setlength{\headsep}{0.2in}
        \lhead{\hwname{} \hwid}%
        \rhead{\hwtype{} \hwnum}%

        % Setup hrule in header
        \renewcommand{\headrulewidth}{0pt}
        \headrule{}

        % Don't put header on first page
        \thispagestyle{plain}

        \begin{center}
            {\Large \hwtype{} \hwnum}

            \hwname{} \hwid
            %
            % \today
        \end{center}
        \renewcommand{\headrulewidth}{0.4pt}
    }

}%
{%
    \renewcommand{\maketitle}[0]{%
        % Make all pages plain
        \pagestyle{plain}

        % Put header on it's own page
        \begin{center}
            {\Large \hwclass{} \hwtype{} \hwnum}

            \hwname{} \hwid

            \today
        \end{center}
        \renewcommand{\headrulewidth}{0.4pt}
        \newpage
    }
}

% ----- For usage with pandoc converted documents -----------------------------

\providecommand{\tightlist}{%
    \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}

% -----------------------------------------------------------------------------

% ----- Source Code -----------------------------------------------------------

\RequirePackage{listings}
\renewcommand{\lstlistingname}{代码}
\RequirePackage{xcolor}
\definecolor{vgreen}{RGB}{104,180,104}
\definecolor{vblue}{RGB}{49,49,255}
\definecolor{vorange}{RGB}{255,143,102}
\lstdefinestyle{code}
{
basicstyle      =   \ttfamily,
keywordstyle    =   \color{vblue},
identifierstyle =   \color{black},
commentstyle    =   \color{vgreen},
numbers         =   left,
numberstyle     =   \color{black},
numbersep       =   10pt,
tabsize         =   8,
moredelim       =   *[s][\colorIndex]{[}{]},
literate        =   *{:}{:}1,
frame           =   lrtb,
frameround      =   tttt,
xleftmargin     =   2em,
xrightmargin    =   1em
}
\lstset{style = code}

\makeatletter
\newcommand*\@lbracket{[}
\newcommand*\@rbracket{]}
\newcommand*\@colon{:}
\newcommand*\colorIndex{%
    \edef\@temp{\the\lst@token}%
    \ifx\@temp\@lbracket \color{black}%
    \else\ifx\@temp\@rbracket \color{black}%
        \else\ifx\@temp\@colon \color{black}%
            \else \color{vorange}%
            \fi\fi\fi
}
\makeatother
