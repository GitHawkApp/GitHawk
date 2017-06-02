#!/usr/bin/env luajit

local ffi = require("ffi")

cmark = ffi.load("libcmark")

ffi.cdef[[
char *cmark_markdown_to_html(const char *text, int len, int options);

typedef enum {
	/* Error status */
	CMARK_NODE_NONE,

	/* Block */
	CMARK_NODE_DOCUMENT,
	CMARK_NODE_BLOCK_QUOTE,
	CMARK_NODE_LIST,
	CMARK_NODE_ITEM,
	CMARK_NODE_CODE_BLOCK,
	CMARK_NODE_HTML,
	CMARK_NODE_PARAGRAPH,
	CMARK_NODE_HEADER,
	CMARK_NODE_HRULE,

	CMARK_NODE_FIRST_BLOCK = CMARK_NODE_DOCUMENT,
	CMARK_NODE_LAST_BLOCK  = CMARK_NODE_HRULE,

	/* Inline */
	CMARK_NODE_TEXT,
	CMARK_NODE_SOFTBREAK,
	CMARK_NODE_LINEBREAK,
	CMARK_NODE_CODE,
	CMARK_NODE_INLINE_HTML,
	CMARK_NODE_EMPH,
	CMARK_NODE_STRONG,
	CMARK_NODE_LINK,
	CMARK_NODE_IMAGE,

	CMARK_NODE_FIRST_INLINE = CMARK_NODE_TEXT,
	CMARK_NODE_LAST_INLINE  = CMARK_NODE_IMAGE,
} cmark_node_type;


typedef enum {
	CMARK_NO_LIST,
	CMARK_BULLET_LIST,
	CMARK_ORDERED_LIST
}  cmark_list_type;

typedef enum {
	CMARK_NO_DELIM,
	CMARK_PERIOD_DELIM,
	CMARK_PAREN_DELIM
} cmark_delim_type;

typedef struct cmark_node cmark_node;
typedef struct cmark_parser cmark_parser;
typedef struct cmark_iter cmark_iter;

typedef enum {
	CMARK_EVENT_NONE,
	CMARK_EVENT_DONE,
	CMARK_EVENT_ENTER,
	CMARK_EVENT_EXIT
} cmark_event_type;

cmark_node*
cmark_node_new(cmark_node_type type);

void
cmark_node_free(cmark_node *node);

cmark_node*
cmark_node_next(cmark_node *node);

cmark_node*
cmark_node_previous(cmark_node *node);

cmark_node*
cmark_node_parent(cmark_node *node);

cmark_node*
cmark_node_first_child(cmark_node *node);

cmark_node*
cmark_node_last_child(cmark_node *node);

cmark_iter*
cmark_iter_new(cmark_node *root);

void
cmark_iter_free(cmark_iter *iter);

cmark_event_type
cmark_iter_next(cmark_iter *iter);

cmark_node*
cmark_iter_get_node(cmark_iter *iter);

cmark_event_type
cmark_iter_get_event_type(cmark_iter *iter);

cmark_node*
cmark_iter_get_root(cmark_iter *iter);

void
cmark_iter_reset(cmark_iter *iter, cmark_node *current,
                 cmark_event_type event_type);

void*
cmark_node_get_user_data(cmark_node *node);

int
cmark_node_set_user_data(cmark_node *node, void *user_data);

cmark_node_type
cmark_node_get_type(cmark_node *node);

const char*
cmark_node_get_type_string(cmark_node *node);

const char*
cmark_node_get_literal(cmark_node *node);

int
cmark_node_set_literal(cmark_node *node, const char *content);

int
cmark_node_get_header_level(cmark_node *node);

int
cmark_node_set_header_level(cmark_node *node, int level);

cmark_list_type
cmark_node_get_list_type(cmark_node *node);

int
cmark_node_set_list_type(cmark_node *node, cmark_list_type type);

cmark_delim_type
cmark_node_get_list_delim(cmark_node *node);

int
cmark_node_set_list_delim(cmark_node *node, cmark_delim_type delim);

int
cmark_node_get_list_start(cmark_node *node);

int
cmark_node_set_list_start(cmark_node *node, int start);

int
cmark_node_get_list_tight(cmark_node *node);

int
cmark_node_set_list_tight(cmark_node *node, int tight);

const char*
cmark_node_get_fence_info(cmark_node *node);

int
cmark_node_set_fence_info(cmark_node *node, const char *info);

const char*
cmark_node_get_url(cmark_node *node);

int
cmark_node_set_url(cmark_node *node, const char *url);

const char*
cmark_node_get_title(cmark_node *node);

int
cmark_node_set_title(cmark_node *node, const char *title);

int
cmark_node_get_start_line(cmark_node *node);

int
cmark_node_get_start_column(cmark_node *node);

int
cmark_node_get_end_line(cmark_node *node);

int
cmark_node_get_end_column(cmark_node *node);

void
cmark_node_unlink(cmark_node *node);

int
cmark_node_insert_before(cmark_node *node, cmark_node *sibling);

int
cmark_node_insert_after(cmark_node *node, cmark_node *sibling);

int
cmark_node_prepend_child(cmark_node *node, cmark_node *child);

int
cmark_node_append_child(cmark_node *node, cmark_node *child);

void
cmark_consolidate_text_nodes(cmark_node *root);

cmark_parser *cmark_parser_new(int options);

void cmark_parser_free(cmark_parser *parser);

void cmark_parser_feed(cmark_parser *parser, const char *buffer, size_t len);

cmark_node *cmark_parser_finish(cmark_parser *parser);

cmark_node *cmark_parse_document(const char *buffer, size_t len, int options);

char *cmark_render_xml(cmark_node *root, int options);

char *cmark_render_html(cmark_node *root, int options);

char *cmark_render_man(cmark_node *root, int options);

char *cmark_render_commonmark(cmark_node *root, int options, int width);

extern const int cmark_version;

extern const char cmark_version_string[];

        ]]

CMARK_OPT_DEFAULT = 0
CMARK_OPT_SOURCEPOS = 1
CMARK_OPT_HARDBREAKS = 2
CMARK_OPT_NORMALIZE = 4
CMARK_OPT_SMART = 8

local inp = io.read("*all")
local doc = cmark.cmark_parse_document(inp, string.len(inp), CMARK_OPT_SMART)
local html = ffi.string(cmark.cmark_render_html(doc, CMARK_OPT_DEFAULT))
print(html)
