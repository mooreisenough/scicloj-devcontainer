#!/bin/bash
set -euo pipefail

# Default to minimal cleanup if BUILDTYPE not provided
BUILDTYPE="${BUILDTYPE:-minimal}"

# Find the installed Dyalog unicode directory if present
DYALOG_DIR=$(ls -d /opt/mdyalog/*/64/unicode 2>/dev/null || true)

if [ "$BUILDTYPE" = "minimal" ] && [ -n "$DYALOG_DIR" ]; then
  cd "$DYALOG_DIR" || exit 0

  echo "Trimming Dyalog install at $DYALOG_DIR"

  rm -rf aplfmt 
  rm -rf aplkeys/file_siso 
  rm -rf aplkeys/utf8 
  rm -rf aplkeys/xterm 
  rm -rf aplkeys/screen 
  rm -f aplkeys.sh 
  rm -rf apltrans/utf8 
  rm -rf apltrans/xterm 
  rm -rf apltrans/screen 
  rm -f BuildID 
  rm -f dyalog.BuildID 
  rm -f dyalog.config.example 
  rm -f dyalog.desktop 
  rm -f dyalog.rt 
  rm -f dyalog.svg 
  rm -rf fonts 
  rm -rf help 
  rm -f libcef.so 
  rm -f lib/ademo64.so 
  rm -f lib/testcallback.so 
  rm -f lib/htmlrenderer.so 
  rm -rf make_scripts 
  rm -rf mapl 
  rm -rf outprods 
  rm -rf samples 
  rm -rf DWASamples 
  rm -rf Samples 
  rm -rf TestCertificates 
  rm -f ws/apl2in.dws 
  rm -f ws/apl2pcin.dws 
  rm -f ws/ddb.dws 
  rm -f ws/display.dws 
  rm -f ws/eval.dws 
  rm -f ws/fonts.dws 
  rm -f ws/ftp.dws 
  rm -f ws/groups.dws 
  rm -f ws/max.dws 
  rm -f ws/min.dws 
  rm -f ws/ops.dws 
  rm -f ws/quadna.dws 
  rm -f ws/smdemo.dws 
  rm -f ws/smdesign.dws 
  rm -f ws/smtutor.dws 
  rm -f ws/tube.dws 
  rm -f ws/tutor.dws 
  rm -f ws/xfrcode.dws 
  rm -f ws/xlate.dws 
  rm -rf xflib 
  rm -rf xfsrc 
  rm -f cef.pak 
  rm -f cef_100_percent.pak 
  rm -f cef_200_percent.pak 
  rm -f chrome_100_percent.pak 
  rm -f chrome_200_percent.pak 
  rm -f cef_extensions.pak 
  rm -f chrome-sandbox 
  rm -f devtools_resources.pak 
  rm -f icudtl.dat 
  rm -rf locales 
  rm -f snapshot_blob.bin 
  rm -f natives_blob.bin 
  rm -f lib/libcef.so 
  rm -f lib/libAplWrapper.so 

  # Extra cleanup: patterns and directories commonly large
  rm -rf samples DWASamples Samples TestCertificates outprods make_scripts mapl || true
  rm -f cef.pak icudtl.dat snapshot_blob.bin natives_blob.bin || true
fi

# Ensure downloaded installer and temp files are removed (do this outside the conditional too)
rm -f /tmp/dyalog.deb || true
rm -rf /var/tmp/* /tmp/* || true