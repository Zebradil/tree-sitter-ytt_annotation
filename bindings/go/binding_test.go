package tree_sitter_ytt_annotation_test

import (
	"testing"

	tree_sitter "github.com/tree-sitter/go-tree-sitter"
	tree_sitter_ytt_annotation "github.com/tree-sitter/tree-sitter-ytt_annotation/bindings/go"
)

func TestCanLoadGrammar(t *testing.T) {
	language := tree_sitter.NewLanguage(tree_sitter_ytt_annotation.Language())
	if language == nil {
		t.Errorf("Error loading YttAnnotation grammar")
	}
}
