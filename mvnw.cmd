@REM ----------------------------------------------------------------------------
@REM Licensed to the Apache Software Foundation (ASF) under one
@REM or more contributor license agreements.  See the NOTICE file
@REM distributed with this work for additional information
@REM regarding copyright ownership.  The ASF licenses this file
@REM to you under the Apache License, Version 2.0 (the
@REM "License"); you may not use this file except in compliance
@REM with the License.  You may obtain a copy of the License at
@REM
@REM    https://www.apache.org/licenses/LICENSE-2.0
@REM
@REM Unless required by applicable law or agreed to in writing,
@REM software distributed under the License is distributed on an
@REM "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
@REM KIND, either express or implied.  See the License for the
@REM specific language governing permissions and limitations
@REM under the License.
@REM ----------------------------------------------------------------------------

@REM Apache Maven Wrapper startup batch script, version 3.3.2

@IF "%MAVEN_BATCH_ECHO%"=="on" ECHO %MAVEN_BATCH_ECHO%

IF "%OS%"=="Windows_NT" SETLOCAL

SET DIRNAME=%~dp0
IF "%DIRNAME%"=="" SET DIRNAME=.

SET MAVEN_PROJECTBASEDIR=%MAVEN_BASEDIR%
IF NOT "%MAVEN_PROJECTBASEDIR%"=="" GOTO endDetectBaseDir

SET EXEC_DIR=%CD%
SET WDIR=%EXEC_DIR%
:findBaseDir
IF EXIST "%WDIR%\.mvn" GOTO baseDirFound
cd ..
IF "%WDIR%"=="%CD%" GOTO baseDirNotFound
SET WDIR=%CD%
GOTO findBaseDir

:baseDirFound
SET MAVEN_PROJECTBASEDIR=%WDIR%
cd "%EXEC_DIR%"
GOTO endDetectBaseDir

:baseDirNotFound
SET MAVEN_PROJECTBASEDIR=%EXEC_DIR%
cd "%EXEC_DIR%"

:endDetectBaseDir

IF NOT EXIST "%MAVEN_PROJECTBASEDIR%\.mvn\jvm.config" GOTO endReadAdditionalConfig
@setlocal EnableExtensions EnableDelayedExpansion
FOR /F "usebackq delims=" %%a IN ("%MAVEN_PROJECTBASEDIR%\.mvn\jvm.config") DO SET JVM_CONFIG_MAVEN_PROPS=!JVM_CONFIG_MAVEN_PROPS! %%a
@endlocal & SET JVM_CONFIG_MAVEN_PROPS=%JVM_CONFIG_MAVEN_PROPS%
:endReadAdditionalConfig

SET WRAPPER_JAR="%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.jar"

IF EXIST %WRAPPER_JAR% GOTO runWrapper

FOR /F "usebackq tokens=1,2 delims==" %%A IN ("%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.properties") DO (
    IF "%%A"=="wrapperUrl" SET WRAPPER_URL=%%B
)

powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('%WRAPPER_URL%', %WRAPPER_JAR%)"
IF %ERRORLEVEL% NEQ 0 GOTO error

:runWrapper
FOR /F "usebackq tokens=1,2 delims==" %%A IN ("%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.properties") DO (
    IF "%%A"=="distributionUrl" SET DISTRIBUTION_URL=%%B
)

FOR /F "tokens=*" %%i IN ('powershell -Command "[IO.Path]::GetFileNameWithoutExtension([IO.Path]::GetFileNameWithoutExtension('%DISTRIBUTION_URL%'))"') DO SET DIST_DIR=%%i

IF EXIST "%USERPROFILE%\.m2\wrapper\dists\%DIST_DIR%" (
    FOR /D %%i IN ("%USERPROFILE%\.m2\wrapper\dists\%DIST_DIR%\*") DO SET MAVEN_HOME=%%i
    GOTO runMaven
)

MKDIR "%USERPROFILE%\.m2\wrapper\dists\%DIST_DIR%"
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('%DISTRIBUTION_URL%', '%USERPROFILE%\.m2\wrapper\dists\%DIST_DIR%.zip')"
IF %ERRORLEVEL% NEQ 0 GOTO error
powershell -Command "Expand-Archive '%USERPROFILE%\.m2\wrapper\dists\%DIST_DIR%.zip' '%USERPROFILE%\.m2\wrapper\dists\%DIST_DIR%'"
IF %ERRORLEVEL% NEQ 0 GOTO error
FOR /D %%i IN ("%USERPROFILE%\.m2\wrapper\dists\%DIST_DIR%\*") DO SET MAVEN_HOME=%%i

:runMaven
SET MAVEN=%MAVEN_HOME%\bin\mvn.cmd
IF NOT EXIST "%MAVEN%" GOTO error

%MAVEN% %JVM_CONFIG_MAVEN_PROPS% %MAVEN_OPTS% %*
IF %ERRORLEVEL% NEQ 0 GOTO error
GOTO end

:error
SET ERROR_CODE=%ERRORLEVEL%
IF %ERRORLEVEL% EQU 0 SET ERROR_CODE=1

:end
@ENDLOCAL & SET ERROR_CODE=%ERROR_CODE%
IF "%MAVEN_TERMINATE_CMD%"=="on" EXIT %ERROR_CODE%
EXIT /B %ERROR_CODE%
