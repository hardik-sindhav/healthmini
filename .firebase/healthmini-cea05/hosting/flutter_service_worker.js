'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "e33d53d3c758db15c22ff7c4e372df5f",
"assets/AssetManifest.bin.json": "97d07bec67081cb153538802fb7748d1",
"assets/AssetManifest.json": "e48208a3cf4239bb51f509f571271f81",
"assets/assets/images/logo.png": "e9311b6c3eb158c47f8f6772ac0e9eb1",
"assets/assets/images/no_image_placeholder.png": "fddec5aa5af3a5beb89f423ac22d353c",
"assets/assets/lottie/ani_1.json": "7ca9c6b41622a1eb06ed3c0e68e8f63b",
"assets/assets/lottie/ani_2.json": "70a1dff55105390da3458231007b3e25",
"assets/assets/lottie/ani_3.json": "cbeac604cca0a1877728304126869017",
"assets/assets/lottie/loader.json": "84846e9bd858d12fdec3b75b46aeed4e",
"assets/assets/svg/blob-haikei.svg": "3ffeb9eb3170ef71e6e7c568c9fdd70c",
"assets/assets/svg/blob-haikei_2.svg": "22962db5125ed19a39c803449ec76435",
"assets/assets/svg/contact_icon.svg": "5be1e14d01beeb62bfde0044addda6db",
"assets/assets/svg/health_icon.svg": "132c5e108012100f70fc3043227f58cf",
"assets/assets/svg/how_its_work.svg": "3ff0ada16c7b99d58e52802b4129d3b4",
"assets/assets/svg/Introduction.svg": "be8181ce1409f7f0d3fa6e60c01d814d",
"assets/assets/svg/location.svg": "5e1c4fe5fe94292ca5b130409b055bee",
"assets/assets/svg/no_network.svg": "52c42dd489e31d0dcc3fc678e95c41b2",
"assets/assets/svg/statistics_icon.svg": "b4d488a67ed6fa90df2680691373c8ad",
"assets/assets/svg/svg_shape/shape_1.svg": "ad685cb725e152a5301b0f9d2aa95808",
"assets/assets/svg/svg_shape/shape_10.svg": "e74ba8d3a0287f89a9b463bd6b002b1d",
"assets/assets/svg/svg_shape/shape_11.svg": "5780dcb40f4d0a0cd6cc75f8c839e3b2",
"assets/assets/svg/svg_shape/shape_12.svg": "6d8249d2466d8b51d32710b8cb7f09d0",
"assets/assets/svg/svg_shape/shape_13.svg": "689e024c197a9e5c51f9a1a06f5417ec",
"assets/assets/svg/svg_shape/shape_14.svg": "eee302703cbf50602123fe2dd8b84d66",
"assets/assets/svg/svg_shape/shape_2.svg": "9110aab83a0834db4f12f5e3065154bf",
"assets/assets/svg/svg_shape/shape_3.svg": "f302e116777a74b1bb2b7387e9f6012d",
"assets/assets/svg/svg_shape/shape_4.svg": "f302e116777a74b1bb2b7387e9f6012d",
"assets/assets/svg/svg_shape/shape_5.svg": "5974f4f10ba9f4292e6ced8107c7d4ba",
"assets/assets/svg/svg_shape/shape_6.svg": "c8523c5b50f7637b851bd62e16fe9197",
"assets/assets/svg/svg_shape/shape_7.svg": "244567744ba118353d85f9d81eb33738",
"assets/assets/svg/svg_shape/shape_8.svg": "7a2fb50669d489d9285913a3a495e53f",
"assets/assets/svg/svg_shape/shape_9.svg": "4ef5b47e99fd5486bc4210978d67cb6f",
"assets/assets/svg/youtube_icon.svg": "67f925a6ec1d4a094e3ef530a5648062",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "ce550b6076c4535a6e3803f88132940b",
"assets/NOTICES": "d4bf721240cd0e680630b852bd923c28",
"assets/packages/csc_picker/lib/assets/country.json": "11b8187fd184a2d648d6b5be8c5e9908",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "4c3fdece61c0d14c0d23d0b81896d3f1",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "345206ddb084816fc8373b1e9a55235a",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"icons/icon-192-maskable.png": "a1b55f537469fe3c093a714977b5866f",
"icons/icon-192.png": "fa25ebdf31a8e9a4d789b84709109577",
"icons/icon-512-maskable.png": "9a08882cde7961d56d95854468f5a401",
"icons/icon-512.png": "a139031709d1735a41b361456dc96d84",
"index.html": "2ffe5f12df2dc42cf11df5d8d38efe88",
"/": "2ffe5f12df2dc42cf11df5d8d38efe88",
"main.dart.js": "5a77ffd36d5c2da98c2a075a1f59447f",
"manifest.json": "fd33c5bdeefeccf7f03bb93c29effa02",
"version.json": "a1db15ed97afeb476fd4a990308baa8a"};
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
