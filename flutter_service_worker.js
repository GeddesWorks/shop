'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"manifest.json": "14a71430a33efc201444dde1ad728cab",
"favicon.png": "6cdcdabd3b6c3e9f256a8263b3a24318",
"index.html": "0e0f828b9ced5c10b91f56cb6ad2c878",
"/": "0e0f828b9ced5c10b91f56cb6ad2c878",
"main.dart.js": "59b4e9b8ac6f04b22f852b5551939925",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.json": "627ef8edd0f8d7a76a0c23dc87803b86",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/AssetManifest.bin": "a8b42137f20575945984555587b0dbe1",
"assets/images/GeddesWorksCutout.png": "8cdb080e49c4de813cfc7455ebdc42a9",
"assets/images/PayPal.png": "e67480531490f08ca3e7d021d188bdff",
"assets/images/welcomeImages/5.jpeg": "cbcd17e2ac16dc37004c7677c0be6b45",
"assets/images/welcomeImages/1.jpeg": "327f2a2b878a64b12afd07dae7e220ce",
"assets/images/welcomeImages/4.jpeg": "f37fc1b7c8cfa9c2f1525d61ec2798da",
"assets/images/welcomeImages/2.jpeg": "ebf4b4b6d7314304ebcda45aa5603aca",
"assets/images/welcomeImages/3.jpeg": "4561a3eee4802221a3c4ac67d1c44ecc",
"assets/images/cash-app-logo-512x512.png": "31d037a802d0978aac0052d313a8aa56",
"assets/images/authorizedsellerbadge.png": "55ead554583079dbfacc44fdfb1b79f6",
"assets/images/accentBanner1.png": "1e454ef2199a4658b5bce5202835c29f",
"assets/images/GeddesWorks.png": "c026d4c762393870695977cfbaad934a",
"assets/images/venmo-logo-1024x269.webp": "46d83ad17e93ea094652d3eddc937641",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/fonts/MaterialIcons-Regular.otf": "29269b4f2a2e62845749962914a7faec",
"assets/NOTICES": "c4df37409fedf633d0c3a1a569621a65",
"assets/AssetManifest.bin.json": "440107d882c530bad2201556faf2194a",
"version.json": "53e5875e1b221aa4338183cfc8c56702",
"canvaskit/skwasm.js.symbols": "c37c57bf1a5a958e3144da7df44254b0",
"canvaskit/canvaskit.wasm": "2db534eaad9e980f5028f0bcb8c54756",
"canvaskit/skwasm.wasm": "883abde2920007bba715d8ff470ccf8c",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/chromium/canvaskit.wasm": "d44c5e0a275d8cb84acff28ef31fa06a",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.js.symbols": "0b594584ac3722580082cd02b6da9033",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.js.symbols": "77cdc19fcc63a442fb89bc32e8a6c886",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"icons/Icon-512.png": "badd3a7046cf6dbbccd1424587df14ef",
"icons/Icon-maskable-512.png": "badd3a7046cf6dbbccd1424587df14ef",
"icons/Icon-192.png": "a88d6a50f9fea94ae03dc0cb1a9303b7",
"icons/Icon-maskable-192.png": "a88d6a50f9fea94ae03dc0cb1a9303b7",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
