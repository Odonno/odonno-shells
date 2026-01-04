pragma Singleton

import Quickshell

Singleton {
	function lerp(a: int, b: int, level: real): int {
		return a + (b - a) * level;
	}

	function hexToRgb(hexa: Color) {
		let hexaValue = hexa.replace('#', '');
		if (hexaValue.length === 3) {
			hexaValue = hexaValue.split('').map(c => c + c).join('');
		}

		const hexaAsNumber = parseInt(hexaValue, 16);
		return {
			r: (hexaAsNumber >> 16) & 255,
			g: (hexaAsNumber >> 8) & 255,
			b: hexaAsNumber & 255
		};
	}

	function rgbToHex({ r, g, b }): string {
		return (
			'#' +
			[r, g, b]
			.map(v => Math.round(v).toString(16).padStart(2, '0'))
			.join('')
		);
	}

	function lerpColor(fromHexa: Color, toHexa: Color, t: real): Color {
		const level = Math.min(1, Math.max(0, t));
		const c1 = hexToRgb(fromHexa);
		const c2 = hexToRgb(toHexa);

		return rgbToHex({
			r: lerp(c1.r, c2.r, level),
			g: lerp(c1.g, c2.g, level),
			b: lerp(c1.b, c2.b, level)
		});
	}
}