@echo off
echo Pulling latest changes...
git pull

echo.
echo ---------------------------------------
echo   Updating your dictionary repository
echo ---------------------------------------
echo.

REM Open your dictionary file for editing
start "" "index.html"

echo.
echo When you finish pasting the updated section, save the file.
pause

echo Adding changes...
git add .

echo Committing...
git commit -m "Auto-update dictionary"

echo Pushing to GitHub...
git push

echo.
echo ---------------------------------------
echo   Update complete! GitHub Pages will redeploy.
echo ---------------------------------------
echo.
pause