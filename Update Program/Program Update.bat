@echo off
setlocal

:: ��Ʈ��ũ ����̺� ��� ���� ex)F:
pushd %~dp0

::����Ǵ� ��� ����
set src_driver=%CD%\

goto Config

::Config �б�
:Config
	for /f "tokens=1,2 delims==" %%a in (config.ini) do (
		if %%a==KST_CHECK set KST_CHECK=%%b
		if %%a==BACKUP_CHECK set BACKUP_CHECK=%%b
		if %%a==KST_APP_NAME set KST_APP_NAME=%%b
		if %%a==KST_PATH set KST_PATH=%%b
		if %%a==FOLDER_UPDATE_NAME set FOLDER_UPDATE_NAME=%%b
	)

	:: ������Ʈ ���� �˻�
	IF EXIST "%KST_PATH%" (
		cls
	) ELSE (
		mkdir "%KST_PATH%"
	)
	
	:: ��� ���� üũ
	if "%KST_CHECK%"=="Y" (
		goto BACKUP
	) else (
		Exit 
	)
	
:BACKUP
	:: ��¥ ���ڿ��� ����Ϸ� ����
	set YEAR=%date:~2,2%
	set MONTH=%date:~5,2%
	set DAY=%date:~8,2%
	set BACUP_PATH=%KST_PATH%\%KST_APP_NAME%_%YEAR%%MONTH%%DAY%

	:: ��� ���� üũ
	if "%BACKUP_CHECK%"=="Y" (
		
		:: ���� �˻�
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
	:: ��Ʈ���� ���� - ��� ����

	set dest_path=%KST_PATH%\%KST_APP_NAME%\

	:: ��Ʈ���� �ش� ����
	IF EXIST "%dest_path%" (
  		cls
	) ELSE (
		cls
		mkdir "%dest_path%"
	)
	
	::��Ʈ���� ���� ����
	xcopy "%src_driver%%FOLDER_UPDATE_NAME%" "%dest_path%" /s /y

	goto EXIT

:EXIT
(
	cls

	echo ���� ����Ǿ����ϴ�. 
	timeout /t 5 

	exit
)




