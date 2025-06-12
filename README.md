# AUTests iOS 26
This is a test repo for iOS 26 to observe changes in AudioKit & AVAudioEngine.

In summary:
In iOS 18, When the engine is unloaded while running AudioKitAU will call deinit, deallocateRenderResources.

If the engine was not running AudioKitAU will call deinit.

In iOS 26, When the engine is unloaded while running AudioKitAU will call deallocateRenderResources, deinit, deallocateRenderResources.

If the engine was not running AudioKitAU will call deinit, deallocateRenderResources.
