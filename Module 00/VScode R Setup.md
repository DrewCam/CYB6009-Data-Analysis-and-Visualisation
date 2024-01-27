---
alias:
author:
fileClass: resource
category-resource:
score: x
reviewed: n
date: 2024-01-15
last-review: 2024-01-15
summary: 
---
Project::
Tags:: #R #VSCode #Python #linter #pip #Visual_Studio 
# R in VSCode Setup Windows 11.

Documentation to configure R in VS Code on Windows 11. I have added to the [official doco](https://github.com/REditorSupport/vscode-R/wiki/Installation:-Windows) with an extra step for a C++ Build tools error I received.

- Download and install R. [The Comprehensive R Archive Network (rstudio.com)](https://cran.rstudio.com/)

Install [vscode-R](https://marketplace.visualstudio.com/items?itemName=REditorSupport.r) in VS Code by searching `reditorsupport.r` in extension marketplace.

If your R installation is from [CRAN](http://cran.r-project.org/mirrors.html) with default installation settings, especially **Save version number in registry** is enabled, as the following image shows:

![image](https://user-images.githubusercontent.com/4662568/76700772-ca94ee00-66f5-11ea-97bc-f89afeaf1bd3.png)

Then the default settings should work out of the box. Otherwise, you may have to change `r.rterm.windows` to the path to your R executable, which will be executed on command `Create R Terminal`.

## [](https://github.com/REditorSupport/vscode-R/wiki/Installation:-Windows#languageserver)languageserver

[languageserver](https://github.com/REditorSupport/languageserver) is an implementation of the [Language Server Protocol](https://microsoft.github.io/language-server-protocol/) for R.

Run the following commands in R.

You may install the latest stable release from CRAN:

```r
install.packages("languageserver")
```

or install the development version with the newest features:

```r
remotes::install_github("REditorSupport/languageserver")
```

which requires [Rtools](https://cran.r-project.org/bin/windows/Rtools/) to build.

You can also install the `rmarkdown` package and Pandoc rendering library to see formatted R help pages upon [hover](https://github.com/REditorSupport/vscode-R/wiki/Installation:-Windows#hover). Previews of function documentation without these dependencies will show a plain page.

`rmarkdown` can be installed with:

```r
install.packages("rmarkdown")
```

Pandoc is [automatically installed](https://alexd106.github.io/intro2R/install_rmarkdown.html) if you have RStudio on your machine. See the official installation guide [here](https://pandoc.org/installing.html) if you do not have RStudio.

## [](https://github.com/REditorSupport/vscode-R/wiki/Installation:-Windows#radian)radian

[radian](https://github.com/randy3k/radian) is highly recommended as the R terminal for interactive use.

Since radian is built with python, we need to install python first. Note that radian does not work with the python distributed by Microsoft Store ([radian#120](https://github.com/randy3k/radian/issues/120)) before v0.5.4, we need to install the official version. Go to [Python Releases for Windows](https://www.python.org/downloads/windows/) and download the latest executable installer, e.g. [Windows x86-64 executable installer](https://www.python.org/ftp/python/3.7.7/python-3.7.7-amd64.exe).

![image](https://user-images.githubusercontent.com/4662568/76701870-219fc080-6700-11ea-8487-18ab880dab88.png)

Make sure **Add Python 3.x to PATH** is selected.

Then start a command prompt or Windows PowerShell terminal and type the following command to install `radian` via `pip`:

```shell
pip install -U radian
```

To locate the path to `radian.exe`, run the following command:

```shell
where.exe radian
```

When attempting to `pip` radian the latest version of python is throwing an error below to fix this I downloaded VS build tools, then ran the below query from the folder.

```
error: Microsoft Visual C++ 14.0 or greater is required. Get it with "Microsoft C++ Build Tools": https://visualstudio.microsoft.com/visual-cpp-build-tools/
```

Download Build tools

- [Microsoft C++ Build Tools - Visual Studio](https://visualstudio.microsoft.com/visual-cpp-build-tools/)

From a command prompt. `cd Downloads`

```shell
vs_buildtools.exe --norestart --passive --downloadThenInstall --includeRecommended --add Microsoft.VisualStudio.Workload.NativeDesktop --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Workload.MSBuildTools
```

It is a pretty big install, which is not ideal, I wonder if installing an older version of python would be a workaround? e.g 3.9.

Then the following VS Code settings should be updated to properly use radian as the default terminal. Put the path to `radian.exe` in `r.rterm.windows` with all `\` replaced with `\\`. For example, if your `radian` is installed for `user`:

```json
{
  "r.bracketedPaste": true,
  "r.rterm.windows": "C:\\Users\\user\\AppData\\Local\\Programs\\Python\\Python37\\Scripts\\radian.exe"
}
```

## [](https://github.com/REditorSupport/vscode-R/wiki/Installation:-Windows#vscode-r-debugger)VSCode-R-Debugger

[VSCode-R-Debugger](https://marketplace.visualstudio.com/items?itemName=RDebugger.r-debugger) is a VS Code extension that implements R debugging capabilities. It depends on [vscDebugger](https://github.com/ManuelHentschel/vscDebugger).

1. Install VSCode-R-Debugger extension in VS Code.
2. Install vscDebugger package via

```r
remotes::install_github("ManuelHentschel/vscDebugger")
```

## [](https://github.com/REditorSupport/vscode-R/wiki/Installation:-Windows#httpgd)httpgd

[httpgd](https://github.com/nx10/httpgd) is an R package to provide a graphics device that asynchronously serves SVG graphics via HTTP and WebSockets. It enables the plot viewer based on httpgd in VS Code.

1. Install `httpgd` from CRAN
    
    ```r
    install.packages("httpgd")
    ```
    
2. Enable `r.plot.useHttpgd` in VS Code settings.
    
## [](https://github.com/REditorSupport/vscode-R/wiki/Installation:-Windows#troubleshooting-wsl)Troubleshooting WSL

The connection between VSCode and R may fail if an R session is started on Windows Subsystem for Linux (WSL/WSL2), but VSCode is started outside of the WSL environment (e.g. on plain Windows). For R to work, you must open VSCode _on WSL_ with the `code <directory>` command so that VSCode "thinks" that it is inside the container.

See issue [#910](https://github.com/REditorSupport/vscode-R/issues/910) for details.

## Using it. 

Now simply open VS code, create a new r document `.r` and select a new R interactive Terminal and good to go. You may also wish to modify the linter to enable line lengths of more than 90 if you find the warnings annoying. You can also opt to disable it completely.
