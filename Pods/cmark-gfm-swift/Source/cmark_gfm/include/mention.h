#ifndef MENTION_H
#define MENTION_H

#include "core-extensions.h"

//extern cmark_node_type CMARK_NODE_MENTION;
cmark_syntax_extension *create_mention_extension(void);
//const char *cmark_node_get_mention_login(cmark_node *node);

#endif
