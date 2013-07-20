{\rtf1\ansi\ansicpg1252\cocoartf1187\cocoasubrtf390
{\fonttbl\f0\fmodern\fcharset0 Courier-Oblique;\f1\fmodern\fcharset0 Courier;\f2\fmodern\fcharset0 Courier-Bold;
}
{\colortbl;\red255\green255\blue255;\red135\green136\blue117;\red38\green38\blue38;\red210\green0\blue53;
\red14\green114\blue164;\red14\green110\blue109;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\sl360

\f0\i\fs24 \cf2 #!/bin/sh
\f1\i0 \cf3 \
\

\f0\i \cf2 # If we aren't running from the command line, then exit
\f1\i0 \cf3 \
\pard\pardeftab720\sl360

\f2\b \cf3 if
\f1\b0  
\f2\b [
\f1\b0  \cf4 "$GHUNIT_CLI"\cf3  
\f2\b =
\f1\b0  \cf4 ""\cf3  
\f2\b ]
\f1\b0  
\f2\b &&
\f1\b0  
\f2\b [
\f1\b0  \cf4 "$GHUNIT_AUTORUN"\cf3  
\f2\b =
\f1\b0  \cf4 ""\cf3  
\f2\b ]
\f1\b0 ; 
\f2\b then
\f1\b0 \

\f2\b   
\f1\b0 \cf5 exit \cf3 0\

\f2\b fi
\f1\b0 \
\
\pard\pardeftab720\sl360
\cf5 export \cf6 DYLD_ROOT_PATH
\f2\b \cf3 =
\f1\b0 \cf4 "$SDKROOT"\cf3 \
\cf5 export \cf6 DYLD_FRAMEWORK_PATH
\f2\b \cf3 =
\f1\b0 \cf4 "$CONFIGURATION_BUILD_DIR"\cf3 \
\cf5 export \cf6 IPHONE_SIMULATOR_ROOT
\f2\b \cf3 =
\f1\b0 \cf4 "$SDKROOT"\cf3 \
\pard\pardeftab720\sl360

\f0\i \cf2 #export CFFIXED_USER_HOME="$TEMP_FILES_DIR/iPhone Simulator User Dir" # Be compatible with google-toolbox-for-mac
\f1\i0 \cf3 \
\

\f0\i \cf2 #if [ -d $"CFFIXED_USER_HOME" ]; then
\f1\i0 \cf3 \

\f0\i \cf2 #  rm -rf "$CFFIXED_USER_HOME"
\f1\i0 \cf3 \

\f0\i \cf2 #fi
\f1\i0 \cf3 \

\f0\i \cf2 #mkdir -p "$CFFIXED_USER_HOME"
\f1\i0 \cf3 \
\
\pard\pardeftab720\sl360
\cf5 export \cf6 NSDebugEnabled
\f2\b \cf3 =
\f1\b0 YES\
\cf5 export \cf6 NSZombieEnabled
\f2\b \cf3 =
\f1\b0 YES\
\cf5 export \cf6 NSDeallocateZombies
\f2\b \cf3 =
\f1\b0 NO\
\cf5 export \cf6 NSHangOnUncaughtException
\f2\b \cf3 =
\f1\b0 YES\
\cf5 export \cf6 NSAutoreleaseFreedObjectCheckEnabled
\f2\b \cf3 =
\f1\b0 YES\
\
\cf5 export \cf6 DYLD_FRAMEWORK_PATH
\f2\b \cf3 =
\f1\b0 \cf4 "$CONFIGURATION_BUILD_DIR"\cf3 \
\
\pard\pardeftab720\sl360
\cf6 TEST_TARGET_EXECUTABLE_PATH
\f2\b \cf3 =
\f1\b0 \cf4 "$TARGET_BUILD_DIR/$EXECUTABLE_PATH"\cf3 \
\
\pard\pardeftab720\sl360

\f2\b \cf3 if
\f1\b0  
\f2\b [
\f1\b0  ! -e \cf4 "$TEST_TARGET_EXECUTABLE_PATH"\cf3  
\f2\b ]
\f1\b0 ; 
\f2\b then
\f1\b0 \

\f2\b   
\f1\b0 \cf5 echo\cf3  \cf4 ""\cf3 \
\'a0\'a0\cf5 echo\cf3  \cf4 "  ------------------------------------------------------------------------"\cf3 \
\'a0\'a0\cf5 echo\cf3  \cf4 "  Missing executable path: "\cf3 \
\'a0\'a0\cf5 echo\cf3  \cf4 "     $TEST_TARGET_EXECUTABLE_PATH."\cf3 \
\'a0\'a0\cf5 echo\cf3  \cf4 "  The product may have failed to build or could have an old xcodebuild in your path (from 3.x instead of 4.x)."\cf3 \
\'a0\'a0\cf5 echo\cf3  \cf4 "  ------------------------------------------------------------------------"\cf3 \
\'a0\'a0\cf5 echo\cf3  \cf4 ""\cf3 \
\'a0\'a0\cf5 exit \cf3 1\

\f2\b fi
\f1\b0 \
\
\pard\pardeftab720\sl360

\f0\i \cf2 # If trapping fails, make sure we kill any running securityd
\f1\i0 \cf3 \
launchctl list | grep GHUNIT_RunIPhoneSecurityd 
\f2\b &&
\f1\b0  launchctl remove GHUNIT_RunIPhoneSecurityd\
\pard\pardeftab720\sl360
\cf6 SCRIPTS_PATH
\f2\b \cf3 =
\f1\b0 \cf4 `\cf5 cd\cf3  
\f2\b $(
\f1\b0 dirname \cf6 $0
\f2\b \cf3 )
\f1\b0 ; \cf5 pwd\cf4 `\cf3 \
launchctl submit -l GHUNIT_RunIPhoneSecurityd -- \cf4 "$SCRIPTS_PATH"\cf3 /RunIPhoneSecurityd.sh \cf6 $IPHONE_SIMULATOR_ROOT\cf3  \cf6 $CFFIXED_USER_HOME\cf3 \
\pard\pardeftab720\sl360
\cf5 trap\cf3  \cf4 "launchctl remove GHUNIT_RunIPhoneSecurityd"\cf3  EXIT TERM INT\
\
\pard\pardeftab720\sl360
\cf6 RUN_CMD
\f2\b \cf3 =
\f1\b0 \cf4 "\\"$TEST_TARGET_EXECUTABLE_PATH\\" -RegisterForSystemEvents"\cf3 \
\
\pard\pardeftab720\sl360
\cf5 echo\cf3  \cf4 "Running: $RUN_CMD"\cf3 \
\cf5 set\cf3  +o errexit 
\f0\i \cf2 # Disable exiting on error so script continues if tests fail
\f1\i0 \cf3 \
\cf5 eval\cf3  \cf6 $RUN_CMD\cf3 \
\pard\pardeftab720\sl360
\cf6 RETVAL
\f2\b \cf3 =
\f1\b0 \cf6 $?\cf3 \
\pard\pardeftab720\sl360
\cf5 set\cf3  -o errexit\
\
\cf5 unset \cf3 DYLD_ROOT_PATH\
\cf5 unset \cf3 DYLD_FRAMEWORK_PATH\
\cf5 unset \cf3 IPHONE_SIMULATOR_ROOT\
\
\pard\pardeftab720\sl360

\f2\b \cf3 if
\f1\b0  
\f2\b [
\f1\b0  -n \cf4 "$WRITE_JUNIT_XML"\cf3  
\f2\b ]
\f1\b0 ; 
\f2\b then
\f1\b0 \

\f2\b   
\f1\b0 \cf6 MY_TMPDIR
\f2\b \cf3 =
\f1\b0 \cf4 `\cf3 /usr/bin/getconf DARWIN_USER_TEMP_DIR\cf4 `\cf3 \
\'a0\'a0\cf6 RESULTS_DIR
\f2\b \cf3 =
\f1\b0 \cf4 "$\{MY_TMPDIR\}test-results"\cf3 \
\
\'a0\'a0
\f2\b if
\f1\b0  
\f2\b [
\f1\b0  -d \cf4 "$RESULTS_DIR"\cf3  
\f2\b ]
\f1\b0 ; 
\f2\b then
\f1\b0 \
	\cf4 `\cf6 $CP\cf3  -r \cf4 "$RESULTS_DIR"\cf3  \cf4 "$BUILD_DIR"\cf3  
\f2\b &&
\f1\b0  rm -r \cf4 "$RESULTS_DIR"`\cf3 \
\'a0\'a0
\f2\b fi
\f1\b0 \

\f2\b fi
\f1\b0 \
\
\pard\pardeftab720\sl360
\cf5 exit\cf3  \cf6 $RETVAL\cf3 \
}