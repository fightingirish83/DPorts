--- ./src/cronolog.c.orig	2010-12-02 13:41:57.000000000 -0800
+++ ./src/cronolog.c	2010-12-02 13:42:30.000000000 -0800
@@ -84,8 +84,8 @@
 
 #ifndef _WIN32
 #define _GNU_SOURCE 1
-#define OPEN_EXCLUSIVE O_WRONLY|O_CREAT|O_EXCL|O_APPEND|O_LARGEFILE
-#define OPEN_SHARED O_WRONLY|O_CREAT|O_APPEND|O_LARGEFILE
+#define OPEN_EXCLUSIVE O_WRONLY|O_CREAT|O_EXCL|O_APPEND
+#define OPEN_SHARED O_WRONLY|O_CREAT|O_APPEND
 #else
 #define OPEN_EXCLUSIVE O_WRONLY|O_CREAT|O_EXCL|O_APPEND
 #define OPEN_SHARED O_WRONLY|O_CREAT|O_APPEND
