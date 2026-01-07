// vim: set ts=2 sw=2 et:

const PREC = {
  COMMENT: 1,
  LAMBDA: 2,
  CONDITIONAL: 3,
  ASSIGN: 4,
  OR: 5,
  AND: 6,
  NOT: 7,
  REL: 8,
  ADD: 9,
  MULT: 10,
  CALL: 11,
  MEMBER: 12,
};

export default grammar({
  name: 'ytt_annotation',

  extras: ($) => [/\s/, $.comment],

  word: ($) => $.identifier,

  rules: {
    annotation: ($) =>
      seq(
        field('name', $.annotation_name),
        optional(commaSep($.argument_pair)),
      ),

    annotation_name: ($) => /[\w-]+\/[\w-]+/,

    argument_pair: ($) =>
      seq(field('name', $.identifier), '=', field('value', $._expression)),

    _expression: ($) =>
      choice(
        $.identifier,
        $.integer,
        $.float,
        $.string,
        $.boolean,
        $.none,
        $.list,
        $.dictionary,
        $.function_call,
        $.lambda,
        $.unary_expression,
        $.binary_expression,
        $.if_expression,
        $.parenthesized_expression,
      ),

    parenthesized_expression: ($) => seq('(', $._expression, ')'),

    identifier: ($) => /[a-zA-Z_]\w*/,

    string: ($) =>
      choice(
        seq('"', repeat(choice(/[^"\\]/, /\\./)), '"'),
        seq("'", repeat(choice(/[^'\\]/, /\\./)), "'"),
      ),

    integer: ($) => /\d+/,
    float: ($) => /\d+\.\d+/,
    boolean: ($) => choice('True', 'False', 'true', 'false'),
    none: ($) => 'None',

    list: ($) => seq('[', commaSep($._expression), ']'),

    dictionary: ($) => seq('{', commaSep($.pair), '}'),

    pair: ($) =>
      seq(field('key', $._expression), ':', field('value', $._expression)),

    function_call: ($) =>
      prec(
        PREC.CALL,
        seq(
          field('function', $.identifier),
          '(',
          commaSep(choice($._expression, $.argument_pair)),
          ')',
        ),
      ),

    lambda: ($) =>
      prec(
        PREC.LAMBDA,
        seq(
          'lambda',
          optional(field('parameters', $.parameter_list)),
          ':',
          field('body', choice($.return_statement, $._expression)),
        ),
      ),

    parameter_list: ($) => sep1($.identifier, ','),

    return_statement: ($) => seq('return', $._expression),

    if_expression: ($) =>
      prec.right(
        PREC.CONDITIONAL,
        seq($._expression, 'if', $._expression, 'else', $._expression),
      ),

    unary_expression: ($) =>
      prec(PREC.NOT, seq(choice('-', 'not', '!'), $._expression)),

    binary_expression: ($) =>
      choice(
        prec.left(
          PREC.MULT,
          seq($._expression, choice('*', '/', '%'), $._expression),
        ),
        prec.left(
          PREC.ADD,
          seq($._expression, choice('+', '-'), $._expression),
        ),
        prec.left(
          PREC.REL,
          seq(
            $._expression,
            choice('<', '<=', '>', '>=', '==', '!=', 'in'),
            $._expression,
          ),
        ),
        prec.left(PREC.AND, seq($._expression, 'and', $._expression)),
        prec.left(PREC.OR, seq($._expression, 'or', $._expression)),
      ),

    comment: ($) => token(seq('#', /.*/)),
  },
});

function sep1(rule, separator) {
  return seq(rule, repeat(seq(separator, rule)));
}

function commaSep(rule) {
  return optional(sep1(rule, ','));
}
