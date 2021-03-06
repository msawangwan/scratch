// // https://datastation.multiprocess.io/blog/2021-07-15-writing-an-efficient-javascript-object-previewer.html

// function unsafePreviewArray(
//   obj: any,
//   nKeys: number,
//   stringMax: number,
//   nextNKeys: number,
//   prefixChar: string,
//   joinChar: string
// ) {
//   const keys = obj.slice(0, nKeys);
//   const childPreview = keys.map(
//     (o: string) => prefixChar + unsafePreview(o, nextNKeys, stringMax)
//   );
//   if (obj.length > nKeys) {
//     childPreview.push(prefixChar + '...');
//   }
//   return ['[', childPreview.join(',' + joinChar), ']'].join(joinChar);
// }

// function unsafePreviewObject(
//   obj: any,
//   nKeys: number,
//   stringMax: number,
//   nextNKeys: number,
//   prefixChar: string,
//   joinChar: string
// ) {
//   const keys = Object.keys(obj);
//   keys.sort();
//   const firstKeys = keys.slice(0, nKeys);
//   const preview: Array = [];
//   firstKeys.forEach((k) => {
//     const formattedKey = `"${k.replaceAll('"', '\\"')}"`;
//     preview.push(
//       prefixChar +
//       formattedKey +
//       ': ' +
//       unsafePreview(obj[k], nextNKeys, stringMax)
//     );
//   });

//   if (keys.length > nKeys) {
//     preview.push(prefixChar + '...');
//   }

//   return ['{', preview.join(',' + joinChar), '}'].join(joinChar);
// }

// function unsafePreview(
//   obj: any,
//   nKeys: number,
//   stringMax: number,
//   topLevel = false
// ): string {
//   if (!obj) {
//     return String(obj);
//   }

//   // Decrease slightly slower than (nKeys / 2) each time
//   const nextNKeys = nKeys < 1 ? 0 : Math.floor(nKeys * 0.6);
//   const joinChar = topLevel ? '\n' : ' ';
//   const prefixChar = topLevel ? '  ' : '';

//   if (Array.isArray(obj)) {
//     return unsafePreviewArray(
//       obj,
//       nKeys,
//       stringMax,
//       nextNKeys,
//       prefixChar,
//       joinChar
//     );
//   }

//   if (typeof obj === 'object') {
//     return unsafePreviewObject(
//       obj,
//       nKeys,
//       stringMax,
//       nextNKeys,
//       prefixChar,
//       joinChar
//     );
//   }

//   let res = String(obj).slice(0, stringMax);
//   if (String(obj).length > stringMax) {
//     res += '...';
//   }

//   if (typeof obj === 'string' && !topLevel) {
//     res = `"${res.replace('"', '\\"')}"`;
//   }

//   return res;
// }

// export function previewObject(obj: any, nKeys = 20, stringMax = 200): string {
//   try {
//     return unsafePreview(obj, nKeys, stringMax, true);
//   } catch (e) {
//     console.error(e);
//     return String(obj).slice(0, stringMax);
//   }
// }
