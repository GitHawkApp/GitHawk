#include <stdlib.h>
#include "chunk.h"
#include "scanners.h"

bufsize_t _scan_at(bufsize_t (*scanner)(const unsigned char *), cmark_chunk *c, bufsize_t offset)
{
	bufsize_t res;
	unsigned char *ptr = (unsigned char *)c->data;
	unsigned char lim = ptr[c->len];

	ptr[c->len] = '\0';
	res = scanner(ptr + offset);
	ptr[c->len] = lim;

	return res;
}

/*!re2c
  re2c:define:YYCTYPE  = "unsigned char";
  re2c:define:YYCURSOR = p;
  re2c:define:YYMARKER = marker;
  re2c:define:YYCTXMARKER = marker;
  re2c:yyfill:enable = 0;

  wordchar = [^\x00-\x20];

  spacechar = [ \t\v\f\r\n];

  reg_char     = [^\\()\x00-\x20];

  escaped_char = [\\][!"#$%&'()*+,./:;<=>?@[\\\]^_`{|}~-];

  tagname = [A-Za-z][A-Za-z0-9-]*;

  blocktagname = 'address'|'article'|'aside'|'base'|'basefont'|'blockquote'|'body'|'caption'|'center'|'col'|'colgroup'|'dd'|'details'|'dialog'|'dir'|'div'|'dl'|'dt'|'fieldset'|'figcaption'|'figure'|'footer'|'form'|'frame'|'frameset'|'h1'|'head'|'header'|'hr'|'html'|'legend'|'li'|'link'|'main'|'menu'|'menuitem'|'meta'|'nav'|'noframes'|'ol'|'optgroup'|'option'|'p'|'param'|'pre'|'section'|'source'|'title'|'summary'|'table'|'tbody'|'td'|'tfoot'|'th'|'thead'|'title'|'tr'|'track'|'ul';

  attributename = [a-zA-Z_:][a-zA-Z0-9:._-]*;

  unquotedvalue = [^\"'=<>`\x00]+;
  singlequotedvalue = ['][^'\x00]*['];
  doublequotedvalue = [\"][^\"\x00]*[\"];

  attributevalue = unquotedvalue | singlequotedvalue | doublequotedvalue;

  attributevaluespec = spacechar* [=] spacechar* attributevalue;

  attribute = spacechar+ attributename attributevaluespec?;

  opentag = tagname attribute* spacechar* [/]? [>];
  closetag = [/] tagname spacechar* [>];

  htmlcomment = "!---->" | ("!--" ([-]? [^\x00>-]) ([-]? [^\x00-])* "-->");

  processinginstruction = "?" ([^?>\x00]+ | [?][^>\x00] | [>])* "?>";

  declaration = "!" [A-Z]+ spacechar+ [^>\x00]* ">";

  cdata = "![CDATA[" ([^\]\x00]+ | "]" [^\]\x00] | "]]" [^>\x00])* "]]>";

  htmltag = opentag | closetag | htmlcomment | processinginstruction |
            declaration | cdata;

  in_parens_nosp   = [(] (reg_char|escaped_char|[\\])* [)];

  in_double_quotes = ["] (escaped_char|[^"\x00])* ["];
  in_single_quotes = ['] (escaped_char|[^'\x00])* ['];
  in_parens        = [(] (escaped_char|[^)\x00])* [)];

  scheme = 'coap'|'doi'|'javascript'|'aaa'|'aaas'|'about'|'acap'|'cap'|'cid'|'crid'|'data'|'dav'|'dict'|'dns'|'file'|'ftp'|'geo'|'go'|'gopher'|'h323'|'http'|'https'|'iax'|'icap'|'im'|'imap'|'info'|'ipp'|'iris'|'iris.beep'|'iris.xpc'|'iris.xpcs'|'iris.lwz'|'ldap'|'mailto'|'mid'|'msrp'|'msrps'|'mtqp'|'mupdate'|'news'|'nfs'|'ni'|'nih'|'nntp'|'opaquelocktoken'|'pop'|'pres'|'rtsp'|'service'|'session'|'shttp'|'sieve'|'sip'|'sips'|'sms'|'snmp'|'soap.beep'|'soap.beeps'|'tag'|'tel'|'telnet'|'tftp'|'thismessage'|'tn3270'|'tip'|'tv'|'urn'|'vemmi'|'ws'|'wss'|'xcon'|'xcon-userid'|'xmlrpc.beep'|'xmlrpc.beeps'|'xmpp'|'z39.50r'|'z39.50s'|'adiumxtra'|'afp'|'afs'|'aim'|'apt'|'attachment'|'aw'|'beshare'|'bitcoin'|'bolo'|'callto'|'chrome'|'chrome-extension'|'com-eventbrite-attendee'|'content'|'cvs'|'dlna-playsingle'|'dlna-playcontainer'|'dtn'|'dvb'|'ed2k'|'facetime'|'feed'|'finger'|'fish'|'gg'|'git'|'gizmoproject'|'gtalk'|'hcp'|'icon'|'ipn'|'irc'|'irc6'|'ircs'|'itms'|'jar'|'jms'|'keyparc'|'lastfm'|'ldaps'|'magnet'|'maps'|'market'|'message'|'mms'|'ms-help'|'msnim'|'mumble'|'mvn'|'notes'|'oid'|'palm'|'paparazzi'|'platform'|'proxy'|'psyc'|'query'|'res'|'resource'|'rmi'|'rsync'|'rtmp'|'secondlife'|'sftp'|'sgn'|'skype'|'smb'|'soldat'|'spotify'|'ssh'|'steam'|'svn'|'teamspeak'|'things'|'udp'|'unreal'|'ut2004'|'ventrilo'|'view-source'|'webcal'|'wtai'|'wyciwyg'|'xfire'|'xri'|'ymsgr';
*/

// Try to match a scheme including colon.
bufsize_t _scan_scheme(const unsigned char *p)
{
  const unsigned char *marker = NULL;
  const unsigned char *start = p;
/*!re2c
  scheme [:] { return (bufsize_t)(p - start); }
  .? { return 0; }
*/
}

// Try to match URI autolink after first <, returning number of chars matched.
bufsize_t _scan_autolink_uri(const unsigned char *p)
{
  const unsigned char *marker = NULL;
  const unsigned char *start = p;
/*!re2c
  scheme [:][^\x00-\x20<>]*[>]  { return (bufsize_t)(p - start); }
  .? { return 0; }
*/
}

// Try to match email autolink after first <, returning num of chars matched.
bufsize_t _scan_autolink_email(const unsigned char *p)
{
  const unsigned char *marker = NULL;
  const unsigned char *start = p;
/*!re2c
  [a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+
    [@]
    [a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?
    ([.][a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*
    [>] { return (bufsize_t)(p - start); }
  .? { return 0; }
*/
}

// Try to match an HTML tag after first <, returning num of chars matched.
bufsize_t _scan_html_tag(const unsigned char *p)
{
  const unsigned char *marker = NULL;
  const unsigned char *start = p;
/*!re2c
  htmltag { return (bufsize_t)(p - start); }
  .? { return 0; }
*/
}

// Try to match an HTML block tag start line, returning
// an integer code for the type of block (1-6, matching the spec).
// #7 is handled by a separate function, below.
bufsize_t _scan_html_block_start(const unsigned char *p)
{
  const unsigned char *marker = NULL;
/*!re2c
  [<] ('script'|'pre'|'style') (spacechar | [>]) { return 1; }
  '<!--' { return 2; }
  '<?' { return 3; }
  '<!' [A-Z] { return 4; }
  '<![CDATA[' { return 5; }
  [<] [/]? blocktagname (spacechar | [/]? [>])  { return 6; }
  .? { return 0; }
*/
}

// Try to match an HTML block tag start line of type 7, returning
// 7 if successful, 0 if not.
bufsize_t _scan_html_block_start_7(const unsigned char *p)
{
  const unsigned char *marker = NULL;
/*!re2c
  [<] (opentag | closetag) [\t\n\f ]* [\r\n] { return 7; }
  .? { return 0; }
*/
}

// Try to match an HTML block end line of type 1
bufsize_t _scan_html_block_end_1(const unsigned char *p)
{
  const unsigned char *marker = NULL;
  const unsigned char *start = p;
/*!re2c
  .* [<] [/] ('script'|'pre'|'style') [>] { return (bufsize_t)(p - start); }
  .? { return 0; }
*/
}

// Try to match an HTML block end line of type 2
bufsize_t _scan_html_block_end_2(const unsigned char *p)
{
  const unsigned char *marker = NULL;
  const unsigned char *start = p;
/*!re2c
  .* '-->' { return (bufsize_t)(p - start); }
  .? { return 0; }
*/
}

// Try to match an HTML block end line of type 3
bufsize_t _scan_html_block_end_3(const unsigned char *p)
{
  const unsigned char *marker = NULL;
  const unsigned char *start = p;
/*!re2c
  .* '?>' { return (bufsize_t)(p - start); }
  .? { return 0; }
*/
}

// Try to match an HTML block end line of type 4
bufsize_t _scan_html_block_end_4(const unsigned char *p)
{
  const unsigned char *marker = NULL;
  const unsigned char *start = p;
/*!re2c
  .* '>' { return (bufsize_t)(p - start); }
  .? { return 0; }
*/
}

// Try to match an HTML block end line of type 5
bufsize_t _scan_html_block_end_5(const unsigned char *p)
{
  const unsigned char *marker = NULL;
  const unsigned char *start = p;
/*!re2c
  .* ']]>' { return (bufsize_t)(p - start); }
  .? { return 0; }
*/
}

// Try to match a URL in a link or reference, return number of chars matched.
// This may optionally be contained in <..>; otherwise
// whitespace and unbalanced right parentheses aren't allowed.
// Newlines aren't ever allowed.
bufsize_t _scan_link_url(const unsigned char *p)
{
  const unsigned char *marker = NULL;
  const unsigned char *start = p;
/*!re2c
  [ \r\n]* [<] ([^<>\r\n\\\x00] | escaped_char | [\\])* [>] { return (bufsize_t)(p - start); }
  [ \r\n]* (reg_char+ | escaped_char | in_parens_nosp | [\\][^()])* { return (bufsize_t)(p - start); }
  .? { return 0; }
*/
}

// Try to match a link title (in single quotes, in double quotes, or
// in parentheses), returning number of chars matched.  Allow one
// level of internal nesting (quotes within quotes).
bufsize_t _scan_link_title(const unsigned char *p)
{
  const unsigned char *marker = NULL;
  const unsigned char *start = p;
/*!re2c
  ["] (escaped_char|[^"\x00])* ["]   { return (bufsize_t)(p - start); }
  ['] (escaped_char|[^'\x00])* ['] { return (bufsize_t)(p - start); }
  [(] (escaped_char|[^)\x00])* [)]  { return (bufsize_t)(p - start); }
  .? { return 0; }
*/
}

// Match space characters, including newlines.
bufsize_t _scan_spacechars(const unsigned char *p)
{
  const unsigned char *marker = NULL;
  const unsigned char *start = p; \
/*!re2c
  [ \t\v\f\r\n]* { return (bufsize_t)(p - start); }
  . { return 0; }
*/
}

// Match ATX header start.
bufsize_t _scan_atx_header_start(const unsigned char *p)
{
  const unsigned char *marker = NULL;
  const unsigned char *start = p;
/*!re2c
  [#]{1,6} ([ ]+|[\r\n])  { return (bufsize_t)(p - start); }
  .? { return 0; }
*/
}

// Match setext header line.  Return 1 for level-1 header,
// 2 for level-2, 0 for no match.
bufsize_t _scan_setext_header_line(const unsigned char *p)
{
  const unsigned char *marker = NULL;
/*!re2c
  [=]+ [ ]* [\r\n] { return 1; }
  [-]+ [ ]* [\r\n] { return 2; }
  .? { return 0; }
*/
}

// Scan a horizontal rule line: "...three or more hyphens, asterisks,
// or underscores on a line by themselves. If you wish, you may use
// spaces between the hyphens or asterisks."
bufsize_t _scan_hrule(const unsigned char *p)
{
  const unsigned char *marker = NULL;
  const unsigned char *start = p;
/*!re2c
  ([*][ ]*){3,} [ \t]* [\r\n] { return (bufsize_t)(p - start); }
  ([_][ ]*){3,} [ \t]* [\r\n] { return (bufsize_t)(p - start); }
  ([-][ ]*){3,} [ \t]* [\r\n] { return (bufsize_t)(p - start); }
  .? { return 0; }
*/
}

// Scan an opening code fence.
bufsize_t _scan_open_code_fence(const unsigned char *p)
{
  const unsigned char *marker = NULL;
  const unsigned char *start = p;
/*!re2c
  [`]{3,} / [^`\r\n\x00]*[\r\n] { return (bufsize_t)(p - start); }
  [~]{3,} / [^~\r\n\x00]*[\r\n] { return (bufsize_t)(p - start); }
  .?                        { return 0; }
*/
}

// Scan a closing code fence with length at least len.
bufsize_t _scan_close_code_fence(const unsigned char *p)
{
  const unsigned char *marker = NULL;
  const unsigned char *start = p;
/*!re2c
  [`]{3,} / [ \t]*[\r\n] { return (bufsize_t)(p - start); }
  [~]{3,} / [ \t]*[\r\n] { return (bufsize_t)(p - start); }
  .? { return 0; }
*/
}

// Scans an entity.
// Returns number of chars matched.
bufsize_t _scan_entity(const unsigned char *p)
{
  const unsigned char *marker = NULL;
  const unsigned char *start = p;
/*!re2c
  [&] ([#] ([Xx][A-Fa-f0-9]{1,8}|[0-9]{1,8}) |[A-Za-z][A-Za-z0-9]{1,31} ) [;]
     { return (bufsize_t)(p - start); }
  .? { return 0; }
*/
}

// Returns positive value if a URL begins in a way that is potentially
// dangerous, with javascript:, vbscript:, file:, or data:, otherwise 0.
bufsize_t _scan_dangerous_url(const unsigned char *p)
{
  const unsigned char *marker = NULL;
  const unsigned char *start = p;
/*!re2c
  'data:image/' ('png'|'gif'|'jpeg'|'webp') { return 0; }
  'javascript:' | 'vbscript:' | 'file:' | 'data:' { return (bufsize_t)(p - start); }
  .? { return 0; }
*/
}

