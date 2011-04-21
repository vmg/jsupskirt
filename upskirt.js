function markdown(text) {
	var ptr = _JSUPS_parse(Pointer_make(intArrayFromString(text)))
	var len = String_len(ptr)
	var ret = '';

	for (var i = 0; i < len; i++) {
		ret += String.fromCharCode(IHEAP[ptr + i]);
	}
	return ret;  
}

arguments = [];
