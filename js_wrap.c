#include <string.h>
#include <markdown.h>
#include <xhtml.h>

const char *JSUPS_parse(char *text)
{
	struct mkd_renderer renderer;
	struct buf ib = {0, 0, 0, 0, 0};
	struct buf *ob;

	ib.data = text;
	ib.size = strlen(text);

	ob = bufnew(64);

	ups_xhtml_renderer(&renderer, 0);
	ups_markdown(ob, &ib, &renderer, 0xFF);
	ups_free_renderer(&renderer);

	ob->data[ob->size] = 0;
	return ob->data;
}
