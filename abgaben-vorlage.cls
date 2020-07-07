% github.com/oljohnny | 2020

\NeedsTeXFormat{LaTeX2e}                                        % specify minimum tex version
\ProvidesClass{abgaben-vorlage}[2020/06/29 Uni Abgaben Vorlage] % create custom document class

\LoadClass{article}

% automagically calulate and set "headheight" & "footskip"
\usepackage{atveryend}
\makeatletter
\AtVeryEndDocument{%
  \if@filesw % respect \nofiles
    \begingroup
      % same write register as environment `filecontents` uses
      \chardef\reserved@c=15 %
      \immediate\openout\reserved@c=\jobname.heights\relax
      \immediate\write\reserved@c{%
        \string\setlength{\string\headheight}{\the\headheight}%
      }%
      \immediate\write\reserved@c{%
        \string\setlength{\string\footskip}{\the\footskip}%
      }%
      \immediate\closeout\reserved@c
    \endgroup
  \fi
}
\makeatother
\InputIfFileExists{\jobname.heights}{}{}

\usepackage{geometry}
\geometry{
	a4paper,
    total = {165mm,252mm},
    margin = 1in,
	left = 25mm,
    top = 95pt,
}
\usepackage{ifxetex}                        % detect "xelatex" compilation enginge
\usepackage{ifthen}                         % make use of "if", "then"
\usepackage{etoolbox}
\usepackage{graphicx}                       % embed pictures, pdfs, etc.
\usepackage{titlesec}                       % select alternative section titles
\usepackage{fancyhdr}                       % fancy custom page headers
\usepackage{tabularx}                       % better tables, do NOT use package "tabular"
\usepackage[singlespacing]{setspace}        % ability to change line spacing
\usepackage{mathtools}                      % enhance the appearance of documents containing a lot of mathematics
\usepackage{amsmath,amsthm,amssymb}         % mathematical features
\usepackage[typewriter, full]{complexity}   % complexity environment
\usepackage{color}                          % view the world/document in color!
\usepackage{listings}                       % codeblocks, etc.
\usepackage{tocloft}                        % table of content
\usepackage[bookmarksnumbered]{hyperref}    % enable links in the document
\usepackage[binary-units=true,per-mode=symbol]{siunitx}  % nice typesetting for SI units


% choose font interpreter based on compilation enginge (xelatex is better)
\ifxetex
\usepackage{fontspec}
\setmainfont [
    Path = ../local-fonts/,
    UprightFont = OpenSans-Regular,
    ItalicFont = OpenSans-Italic,
    BoldFont = OpenSans-Bold
]{}
\setmonofont [
    Path = ../local-fonts/,
    UprightFont = Consolas-Regular,
    ItalicFont = Consolas-Italic,
    BoldFont = Consolas-Bold
]{}
\else
\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage{lmodern}
\fi

% use package "enumitem" for better itemize styling
\usepackage{enumitem}
\setlist[itemize]{
    nolistsep,          % do not add vertical white space before/after items
    leftmargin = 2em,   % spacing between item text and the left text-border
    itemsep = 0.1em,    % vertical space between two items
}

% make nicer paragraphs (no indent, line seperation)
\setlength{\parindent}{0pt}
\setlength{\parskip}{3pt}


% variables
%% "modulename" variable, e.g. "Datenkommunikation und Sicherheit - SS2020"
\newcommand{\modulename}{}
\newcommand{\setmodulename}[1]{
	\renewcommand{\modulename}{#1}
}

%% "sheetnumber" variable, e.g. "4"
\newcommand{\sheetnumber}{}
\newcommand{\setsheetnumber}[1]{
	\renewcommand{\sheetnumber}{#1}
}

%% "groupnumber" variable, e.g. "121"
\newcommand{\groupnumber}{}
\newcommand{\setgroupnumber}[1]{
	\renewcommand{\groupnumber}{#1}
}

%% "teamname" variable, e.g. "Afi Loverz"
\newcommand{\teamname}{}
\newcommand{\setteamname}[1]{
	\renewcommand{\teamname}{#1}
}

%% "author" array (well sort of)
\newcounter{author}
\newcommand{\addauthor}[2]{
	\csdef{authorName\theauthor}{#1}
	\csdef{authorNum\theauthor}{#2}
	\stepcounter{author}
}

%% print author name
\newcommand{\getauthorname}[1]{%
	\csuse{authorName#1}%
}

%% print author number
\newcommand{\getauthornumber}[1]{%
	\csuse{authorNum#1}%
}

%% print author info
\newcommand{\getauthorFull}[1]{%
	\getauthorname{#1}~(\getauthornumber{#1})%
}

%% print out all authors
\newcounter{ct}
\newcommand{\getauthors}{
	\setcounter{ct}{0}
	\whiledo{\value{ct} < \value{author}}
	{
		\mbox{\getauthorFull{\thect}}
		\stepcounter{ct}
        \ifnum \value{ct}=\value{author}{}\else{\\}\fi
    }
}


% german/english title styling
\pagestyle{fancy}               % use fancy page style
\fancyhf{}                      % clear default "plain" page style

%% german layout
\newcommand{\setgerman}{
    \usepackage[ngerman]{babel} % german typsetting
    \lhead {
	    \textbf{\modulename}\\
        Blatt \sheetnumber \leer - Tutorium \groupnumber\\
        Team: \textit{\teamname}
    }
    \rhead {
        \getauthors \hspace{-1em}
    }
}

%% english Layout
\newcommand{\setenglish}{
    \lhead {
	    \textbf{\modulename}\\
        Sheet \sheetnumber \leer - Group \groupnumber\\
        Team: \textit{\teamname}
    }
    \rhead {
        \getauthors \hspace{-1em}
    }
}

%% set footer
\pagenumbering{arabic}          % arabic page numbering
\cfoot {\thepage}               % position page numberung at center bottom of all pages


% renew commands
\renewcommand{\thesection}{Aufgabe \sheetnumber.\arabic{section} - \hspace{-1em}}		% section: custom enumeration title (Aufgabe #1 - #1) with correct spacing
\renewcommand{\thesubsection}{\alph{subsection})\hspace{-2mm}}                          % subsection: alpha enumeration
% macros
\newcommand{\aufgabe}[1]{
    \pagebreak
    \section{#1}
}
\newcommand{\apt}[1]{\subsection{#1}}
\newcommand{\appt}[2]{\subsubsection*{#1){\hspace{2mm} #2}}}
\newcommand{\todo}{\textbf{\textcolor{red}{TODO}}}
\newcommand{\red}[1]{\textcolor{red}{#1}}
%% si shit
\newcommand{\RTT}{\text{RTT}}
\newcommand{\Gbps}{\ensuremath{\leer\si{\giga\bit\per\second}}}
\newcommand{\GBps}{\ensuremath{\leer\si{\giga\byte\per\second}}}
\newcommand{\Mbps}{\ensuremath{\leer\si{\mega\bit\per\second}}}
\newcommand{\MBps}{\ensuremath{\leer\si{\mega\byte\per\second}}}
\newcommand{\Kbps}{\ensuremath{\leer\si{\kilo\bit\per\second}}}
\newcommand{\KBps}{\ensuremath{\leer\si{\kilo\byte\per\second}}}
\newcommand{\bps}{\ensuremath{\leer\si{\bit\per\second}}}
\newcommand{\Bps}{\ensuremath{\leer\si{\byte\per\second}}}
\newcommand{\GB}{\ensuremath{\leer\si{\giga\byte}}}
\newcommand{\Gb}{\ensuremath{\leer\si{\giga\bit}}}
\newcommand{\MB}{\ensuremath{\leer\si{\mega\byte}}}
\newcommand{\Mb}{\ensuremath{\leer\si{\mega\bit}}}
\newcommand{\Kb}{\ensuremath{\leer\si{\kilo\bit}}}
\newcommand{\KB}{\ensuremath{\leer\si{\kilo\byte}}}
\newcommand{\sibit}{\ensuremath{\leer\si{\bit}}}
\newcommand{\sib}{\ensuremath{\leer\si{\byte}}}
\newcommand{\sis}{\ensuremath{\leer\si{\second}}}
\newcommand{\sims}{\ensuremath{\leer\si{\milli\second}}}
\newcommand{\sius}{\ensuremath{\leer\si{\micro\second}}}
\newcommand{\sins}{\ensuremath{\leer\si{\nano\second}}}
\newcommand{\sime}{\ensuremath{\leer\si{\meter}}}
\newcommand{\simps}{\ensuremath{\leer\si{\meter\per\second}}}
%% other
\newcommand{\ip}[1]{\texttt{#1}}
\newcommand{\packet}[1]{\texttt{#1}}
\newcommand{\mathtext}[1]{\ensuremath{\leer\text{#1}}}
\newcommand{\leer}{\,}