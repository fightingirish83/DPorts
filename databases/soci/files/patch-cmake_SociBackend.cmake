--- cmake/SociBackend.cmake.orig	2012-06-19 19:07:03.554808441 +0300
+++ cmake/SociBackend.cmake	2012-06-19 19:07:19.839807427 +0300
@@ -61,6 +61,7 @@ macro(soci_backend NAME)
       string(TOUPPER "${dep}" DEPU)
       list(APPEND THIS_BACKEND_DEPENDS_INCLUDE_DIRS ${${DEPU}_INCLUDE_DIR})
       list(APPEND THIS_BACKEND_DEPENDS_INCLUDE_DIRS ${${DEPU}_INCLUDE_DIRS})
+      list(APPEND THIS_BACKEND_DEPENDS_INCLUDE_DIRS ${${DEPU}_INCLUDE_DIRECTORIES})
       list(APPEND THIS_BACKEND_DEPENDS_LIBRARIES ${${DEPU}_LIBRARIES})
       list(APPEND THIS_BACKEND_DEPENDS_DEFS -DHAVE_${DEPU}=1)
     endif()
