# File: android/app/proguard-rules.pro

# TensorFlow Lite GPU specific rules
-dontwarn org.tensorflow.lite.gpu.GpuDelegateFactory$Options
-keep class org.tensorflow.lite.gpu.GpuDelegate { *; }
-keep class org.tensorflow.lite.gpu.GpuDelegate$Options { *; }
-keep class org.tensorflow.lite.gpu.GpuDelegateFactory { *; }
-keep class org.tensorflow.lite.gpu.GpuDelegateFactory$Options { *; }

# General TensorFlow Lite rules
-keep class org.tensorflow.lite.** { *; }
-keep class org.tensorflow.lite.support.** { *; }
-keep class org.tensorflow.lite.nnapi.** { *; }

# Keep required native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep metadata
-keepattributes *Annotation*
-keepattributes Signature
-dontwarn java.annotation.**