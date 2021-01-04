@echo off
setlocal

:: 네트워크 드라이브 경로 설정 ex)F:
pushd %~dp0

::실행되는 경로 설정
set src_driver=%CD%\

goto Config

::Config 읽기
:Config
	for /f "tokens=1,2 delims==" %%a in (config.ini) do (
		if %%a==KST_CHECK set KST_CHECK=%%b
		if %%a==BACKUP_CHECK set BACKUP_CHECK=%%b
		if %%a==KST_APP_NAME set KST_APP_NAME=%%b
		if %%a==KST_PATH set KST_PATH=%%b
		if %%a==FOLDER_UPDATE_NAME set FOLDER_UPDATE_NAME=%%b
	)

	:: 업데이트 폴더 검사
	IF EXIST "%KST_PATH%" (
		cls
	) ELSE (
		mkdir "%KST_PATH%"
	)
	
	:: 사용 여부 체크
	if "%KST_CHECK%"=="Y" (
		goto BACKUP
	) else (
		Exit 
	)
	
:BACKUP
	:: 날짜 문자열을 년월일로 분해
	set YEAR=%date:~2,2%
	set MONTH=%date:~5,2%
	set DAY=%date:~8,2%
	set BACUP_PATH=%KST_PATH%\%KST_APP_NAME%_%YEAR%%MONTH%%DAY%

	:: 백업 여부 체크
	if "%BACKUP_CHECK%"=="Y" (
		
		:: 폴더 검사
		IF EXIST "%BACUP_PATH%" (
			cls
		) ELSE (
			cls
			mkdir "%BACUP_PATH%"
		)
		
		xcopy "%KST_PATH%\%KST_APP_NAME%" "%BACUP_PATH%" /s	/y
	
		goto COPY	
	) else (
		goto COPY 
	)
	
:COPY 
	:: 스트리밍 서버 - 경로 설정

	set dest_path=%KST_PATH%\%KST_APP_NAME%\

	:: 스트리밍 해당 폴더
	IF EXIST "%dest_path%" (
  		cls
	) ELSE (
		cls
		mkdir "%dest_path%"
	)
	
	::스트리밍 서버 복사
	xcopy "%src_driver%%FOLDER_UPDATE_NAME%" "%dest_path%" /s /y

	goto EXIT

:EXIT
(
	cls

	echo 정상 실행되었습니다. 
	timeout /t 5 

	exit
)




