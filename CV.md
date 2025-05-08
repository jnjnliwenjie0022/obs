```
\documentclass[letterpaper,10pt]{article}
%%%%%%%%%%%%%%%%%%%%%%%
%% BEGIN_FILE: mteck.sty
%% NOTE: Everything between here and END_FILE can
%% be relocated to "mteck.sty" and then included with:
%\usepackage{mteck}

% Dependencies
% NOTE: Some packages (lastpage, hyperref) require second build!
\usepackage[empty]{fullpage}
\usepackage{titlesec}
\usepackage{enumitem}
\usepackage[hidelinks]{hyperref}
\usepackage{fancyhdr}
\usepackage{fontawesome5}
\usepackage{multicol}
\usepackage{bookmark}
\usepackage{lastpage}
\usepackage{amsfonts}
\usepackage{amssymb}
\usepackage{graphicx}
\usepackage{bbding}
\usepackage{pifont}

% Sans-Serif
%\usepackage[sfdefault]{FiraSans}
%\usepackage[sfdefault]{roboto}
%\usepackage[sfdefault]{noto-sans}
%\usepackage[default]{sourcesanspro}

% Serif
\usepackage{CormorantGaramond}
\usepackage{charter}

% Colors
% Use with \color{Name}
% Can wrap entire heaㄨg with {\color{accent} [...] }
\usepackage{xcolor}
\definecolor{accentTitle}{HTML}{0000BB}
\definecolor{accentText}{HTML}{0000BB}
\definecolor{accentLine}{HTML}{0000BB}

% Misc. Options
\pagestyle{fancy}
\fancyhf{}
\fancyfoot{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\urlstyle{same}

% Adjust Margins
\addtolength{\oddsidemargin}{-0.7in}
\addtolength{\evensidemargin}{-0.5in}
\addtolength{\textwidth}{1.19in}
\addtolength{\topmargin}{-0.7in}
\addtolength{\textheight}{1.4in}

\setlength{\multicolsep}{-3.0pt}
\setlength{\columnsep}{-1pt}
\setlength{\tabcolsep}{0pt}
\setlength{\footskip}{3.7pt}
\raggedbottom
\raggedright

% ATS Readability
\input{glyphtounicode}
\pdfgentounicode=1

%-----------------%
% Custom Commands %
%-----------------%

% Centered title along with subtitle between HR
% Usage: \documentTitle{Name}{Details}
\newcommand{\documentTitle}[2]{
  \begin{center}
    {\Huge\color{accentTitle} #1}
    \vspace{10pt}
    {\color{accentLine} \hrule}
    \vspace{2pt}
    %{\footnotesize\color{accentTitle} #2}
    \footnotesize{#2}
    \vspace{2pt}
    {\color{accentLine} \hrule}
  \end{center}
}

% Create a footer with correct padding
% Usage: \documentFooter{\thepage of X}
\newcommand{\documentFooter}[1]{
  \setlength{\footskip}{10.25pt}
  \fancyfoot[C]{\footnotesize #1}
}

% Simple wrapper to set up page numbering
% Usage: \numberedPages
% WARNING: Must run pdflatex twice!
\newcommand{\numberedPages}{
  \documentFooter{\thepage/\pageref{LastPage}}
}

% Section heading with horizontal rule
% Usage: \section{Title}
\titleformat{\section}{
  \vspace{-5pt}
  \color{accentText}
  \raggedright\large\bfseries
}{}{0em}{}[\color{accentLine}\titlerule]

% Section heading with separator and content on same line
% Usage: \tinysection{Title}
\newcommand{\tinysection}[1]{
  \phantomsection
  \addcontentsline{toc}{section}{#1}
  {\large{\bfseries\color{accentText}#1} {\color{accentLine} |}}
}

% Indented line with arguments left/right aligned in document
% Usage: \heading{Left}{Right}
\newcommand{\heading}[2]{
  \hspace{10pt}#1\hfill#2\\
}

% Adds \textbf to \heading
\newcommand{\headingBf}[2]{
  \heading{\textbf{#1}}{\textbf{#2}}
}

% Adds \textit to \heading
\newcommand{\headingIt}[2]{
  \heading{\textit{#1}}{\textit{#2}}
}

% Template for itemized lists
% Usage: \begin{resume_list} [items] \end{resume_list}
\newenvironment{resume_list}{
  \vspace{-10pt}
  \begin{itemize}[itemsep=-2px, parsep=1pt, leftmargin=30pt]
}{
  \end{itemize}
  %\vspace{-8pt}
}

% Formats an item to use as an itemized title
% Usage: \itemTitle{Title}
\newcommand{\itemTitle}[1]{
  \item[] \underline{#1}\vspace{4pt}
}

% Bullets used in itemized lists
\renewcommand\labelitemi{--}

%% END_FILE: mteck.sty
%%%%%%%%%%%%%%%%%%%%%%


%===================%
% Jasonli's Resume %
%===================%

%\numberedPages % NOTE: lastpage requires a second build
%\documentFooter{\thepage of 2} % Does similar without using lastpage
\begin{document}

  %---------%
  % Heading %
  %---------%

  \documentTitle{Jason (Wen-Jie) Li}{
    % Web Version
    %\raisebox{-0.05\height} \faPhone\ [redacted - web copy] ~
    %\raisebox{-0.15\height} \faEnvelope\ [redacted - web copy] ~
    %%
    \href{tel:0937334110}{
      \raisebox{-0.05\height} \faPhone\ 093-733-4110} ~ | ~
    \href{mailto:jnjn0022@gmail.com}{
      \raisebox{-0.15\height} \faEnvelope\ jnjn0022@gmail.com} ~ | ~
    \href{https://www.linkedin.com/in/wen-jie-li-97b281135/}{
      \raisebox{-0.15\height} \faLinkedin\ linkedin.com/in/wen-jie-li-97b281135} ~ | ~
    \href{https://github.com/jnjnliwenjie0022/}{
      \raisebox{-0.15\height} \faGithub\ github.com/jnjnliwenjie0022}
  }

  %---------%
  % Summary %
  %---------%

  \section{Summary}
    \begin{itemize}[itemsep=-2pt, parsep=1pt, leftmargin=30pt]
      \item[\ding{118}] 7+ years of working experience in digital IC design and team management.
      \item[\ding{118}] 7+ years of working experience in verification with UVM-ML/UVM-SV framework and FPGA prototyping.
      \item[\ding{118}] Build up the team from scratch and success in silicon-proven IP and signoff.
    \end{itemize}

  %--------%
  % Skills %
  %--------%

  \section{Skills}
    \begin{itemize}[itemsep=-2pt, parsep=1pt, leftmargin=75pt]
      \item[\textbf{Technology}] Computer Architecture, DLA, RISC-V, SoC, UVM, AMBA Protocol, IEEE 754, FPU
      \item[\textbf{Languages}] (proficient): Verilog, C/C++, SystemVerilog (familiar): Perl, Bash Shell, Tcl
      \item[\textbf{Tools}] NC-Verilog, Dc, IMC, Genus, Verdi, SimVision, HAL, SpyGalss, Superlint, Git
    \end{itemize}

  %------------%
  % Experience %
  %------------%
  
%\newenvironment{resume_list}{
%  \begin{itemize}
%}{
%  \end{itemize}
%  \vspace{-8pt}
%}

% https://latex-tutorial.com/bullet-styles/
  \section{Work Experience}
  \headingBf{ANDES TECHNOLOGY CORPORATION}{Hsinchu City, Taiwan}
  \headingIt{Deputy Manager}{2022/03 –- Present}
  \begin{itemize}[itemsep=-2px, parsep=1pt, leftmargin=30pt] \vspace{-10pt}
  
    \item[\ding{118}] Project leader with 11 members in RD-Computation Acceleration Division
    \begin{itemize}[itemsep=-2px, parsep=1pt,leftmargin=10pt] \vspace{-6pt}
      \item[$\bullet$] \textbf{Build up the ACCeleration (ACC) team in RD-Computation Acceleration Division from scratch}.
      \item[$\bullet$] \textbf{Success in silicon-proven IP and sign off with customers and receive the loyalty and license fee.}
      \item[$\bullet$] Collaborate with the hardware, algorithm, application, marketing, SA, compiler and architecture teams.
    \end{itemize} \vspace{-4pt}
    
    \item[\ding{118}] Project: Andes Deep Learning Accelerator I400 (v1.0), I370 (v1.0/2.0) and I350 (v1.0/1.1/2.0)
    \begin{itemize}[itemsep=-2px, parsep=1pt,leftmargin=10pt] \vspace{-6pt}
      \item[$\bullet$] Responsible for architecture design and implementation for in-house DLA with float16/int32/int16/int8 arithmetic. 
      \begin{itemize}[itemsep=-2px, parsep=1pt,leftmargin=15pt] \vspace{-4pt}
        \item[\ding{217}] Develop scalable AMBA3.0 AHB-Lite/AMBA4.0 AXI-based master DMA engine and slave port engine.
        \item[\ding{217}] Develop scalable TileLink-based nested bus matrix connector and shared memory of multiple banks.
        \item[\ding{217}] Develop scalable GEneral Matrix Multiplication (GEMM) from 0.125 up to 4TOPS.
        \item[\ding{217}] Develop compatible Tensor Operator Set Architecture (TOSA) hardware for more efficient ML framework.
        \item[\ding{217}] Develop IEEE 754-2008-based Floating-Point Units (FPUs) with Multiply-Add-Fused (MAF) architecture.
        \item[\ding{217}] Develop IEEE 754-2008-based Floating-Point Division and Square root Units (DSUs) with SRT radix-4.
        \item[\ding{217}] Develop interrupt, pooling, preemption, and abortion hardware control feature.
        \item[\ding{217}] Develop micro-command, program sequence, and scheduler for memory optimization.
        \item[\ding{217}] Develop architecture-level performance/power/area profiler for in-house DLA estimation and correlation.
        \item[\ding{217}] Develop VerilogPerl language for module or top-level automatic integration and port scaling.
        \item[\ding{217}] Provide AI Subsystem with AndesCore and in-house platform.
      \end{itemize} \vspace{-2pt}
      \item[$\bullet$] Responsible for unit, integration and system verification with UVM-ML/UVM-SV framework and FPGA prototyping.
      \begin{itemize}[itemsep=-2px, parsep=1pt,leftmargin=15pt] \vspace{-4pt}
        \item[\ding{217}] [FIXME] Develop UVM block-level verification unit test for DMA with AXI4.0 slave UVM VIP.
        \item[\ding{217}] [FIXME] Develop system-level verification and FPGA validation through C/Assembly with CMSIS-NN Library.
        \item[\ding{217}] [FIXME] Develop UVM block-level verification unit test for FPUs through UVMC/DPI-C.
      \end{itemize} \vspace{-4pt}
    \end{itemize} \vspace{-4pt}
  \end{itemize} \vspace{-8pt}
  
  \headingIt{Digital IC Advanced Engineer}{2019/09 -– 2022/03}
  \begin{itemize}[itemsep=-2px, parsep=1pt, leftmargin=30pt] \vspace{-10pt}
    \item[\ding{118}] Project: Andes Deep Learning Accelerator I320 EA
    \begin{itemize}[itemsep=-2px, parsep=1pt,leftmargin=10pt] \vspace{-6pt}
      \item[$\bullet$] Responsible for architecture design and implementation for in-house DLA based on RISC-V coprocessor.
    \end{itemize} \vspace{-4pt}
  \end{itemize} \vspace{-8pt}
  
  \headingIt{Internship – VLSI}{2018/07 -– 2019/09}
  \begin{itemize}[itemsep=-2px, parsep=1pt, leftmargin=30pt] \vspace{-10pt}
    \item[\ding{118}] Responsible for the Deep Learning Accelerator profiler
  \end{itemize} \vspace{-8pt}
    
  
  %-----------%
  % Education %
  %-----------%

  \section{Education}
  
  \headingBf{NATIONAL TAIWAN UNIVERSITY OF SCIENCE AND TECHNOLOGY}{Taipei City, Taiwan} % Note: Adding year(s) exposes an implied age
  \headingIt{Master of Electronic and Computer Engineering Degree}{2017/09 -- 2019/09}
  %\headingIt{• Member of Low Power System Laboratory led by Prof. Shanq-Jang Ruan}{}
  %\headingIt{• Cum. GPA: 4.04 / 4.30}{}
  \headingIt{Member of Low Power System Laboratory led by Prof. Shanq-Jang Ruan}{}
  \headingIt{Cum. GPA: 4.04 / 4.30}{}
  
  \vspace{5pt}
  
  \headingBf{TAMKANG UNIVERSITY}{New Taipei City, Taiwan} % Note: Adding year(s) exposes an implied age
  \headingIt{Bachelor of Electronic and Computer Engineering Degree}{2013/09 -- 2017/06}
  %\headingIt{• Cum. GPA: 3.94 / 4.00}{}
  \headingIt{Cum. GPA: 3.94 / 4.00}{}
  
  %\headingBf{State Universit}{} % Note: Adding year(s) exposes an implied age
  %\headingIt{Bachelor of Science in Computer Information Systems}{}
  %\headingIt{Minors: Networking ; Network Security}{}
  
  %\vspace{5pt}
  
  %\headingBf{Certifications}{}
  %\begin{resume_list}
  %  \item Salt \hspace{2pt}- SaltStack Certified Engineer
  %  \item GCP - Professional Cloud Architect
  %\end{resume_list}
  
  
  %----------------------------%
  % Extracurricular Activities %
  %----------------------------%
  
  \section{Publication}
  
  \begin{itemize}[itemsep=-2px, parsep=1pt, leftmargin=10pt]
    \item[{}] \textbf{Li, Wen-Jie}, Ruan, Shanq-Jang and Yang, Dong-Sheng, ``Implementation of Energy-Efficient Fast Convolution Algorithm for Deep Convolutional Neural Networks based on FPGA,'' in \textit{Electronics Letters, vol. 56, no. 10, pp. 485-488}, 2020/05/01. 
    \item[{}] URL: https://doi.org/10.1049/el.2019.4188

    \vspace{5pt}
     
    \item[{}] \textbf{Wen‐Jie Li} and Shanq-Jang Ruan, ``Energy‐Efficient Fast Convolution Algorithm for Deep Convolutional Neural Networks based on FPGA,'' in \textit{VLSI Design/CAD Symposium}, 2019/08/06.
  \end{itemize} \vspace{-8pt}
  


  %\section{Projects}

  %\headingBf{Hospital / Health Science IRB}{Mar 2015 -- Present}
  %\begin{resume_list}
  %  \item Served as non-scientific/unaffiliated patient-representative
  %  \item Reviewed patient consent forms for completeness, accuracy, and clarity
  %  \item Became familiar with industry standards and regulations (OHRP, HIPAA)
  %\end{resume_list}

  %\headingBf{Debian Linux}{Jan 2001 -- Present}
  %\begin{resume_list}
  %  \item Maintained packages in Debian repositories
  %  \item Reviewed and sponsored packages on behalf of prospective Developers
  %  \item Resolved bugs reported in bug tracking system
  %\end{resume_list}

\end{document}
```