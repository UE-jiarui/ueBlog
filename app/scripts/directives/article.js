/**
 * 富文本编辑器封装指令
 *
 */
BlogDirectives.directive('richTextEditor', function($location, $compile) {
    var self = this;
    var directive = {
        restrict: "A",
        replace: true,
        transclude: true,
        scope: {

        },
        template: "<div id='rich_text_editor'>" +
            "<textarea id=\"richtexteditor-content\" style=\"height:300px;width:100%\"></textarea>" +
            "</div>",

        link: function($scope, $element, $attrs) {
            $scope.editor = $('#richtexteditor-content').wysihtml5();

            // $compile($("#rich_text_editor"))($scope);

            //                        $scope.editor = new wysihtml5.Editor( "richtexteditor-content", {

            //                                toolbar : "richtexteditor-toolbar",
            //                              parserRules: wysihtml5ParserRules       
            //                    });

            $scope.$parent.$watch($attrs.content, function(newValue, oldValue) {

                $scope.editor.innerHTML = newValue;
                $scope.editor.data('wysihtml5').editor.composer.setValue( newValue || '' );
                // $scope.editor.composer.setValue(newValue);
            });
            $compile($element.contents())($scope);

            $scope.cancel = function() {
                $scope.$parent.cancel();
            }
            /* $scope.save = function() {
                    var currentTemplateContent = $encryption.encodeHtml( $scope.editor.getValue() );
                    $scope.$parent.currentTemplate.content = currentTemplateContent;
                    $scope.$parent.save();
            }
            */
            $scope.isClean = function() {
                $scope.$parent.isClean();
            }
        }
    }
    return directive;
})
.directive("mdEditor", ['$compile', function($compile){
    var nextId = 0;

    //Make converter only once to save a bit of load each time
    var markdownConverter = new Markdown.Converter();

    return {
        require: 'ngModel',
        replace: true,
        template: '<div class="pagedown-bootstrap-editor"></div>',
        link: function(scope, iElement, iAttrs, ngModel) {

            var editorUniqueId = nextId++;

            var newElement = $compile('<div>' + '<div class="wmd-panel">' + '<div id="wmd-button-bar-' + editorUniqueId + '"></div>' + '<textarea class="wmd-input" id="wmd-input-' + editorUniqueId + '">' + '</textarea>' + '</div>' + '<div id="wmd-preview-' + editorUniqueId + '" class="wmd-panel wmd-preview"></div>' + '</div>')(scope);

            iElement.html(newElement);

            var converter = new Markdown.Converter();

            // var help = function() {
            //     alert("Do you need help?");
            // }

            var editor = new Markdown.Editor(converter, "-" + editorUniqueId, {
                // handler: help
            });

            editor.run();

            var $wmdInput = $("#wmd-input-" + editorUniqueId);

            // $compile(iElement.contents())(scope);
            // local -> parent scope change (model)
            $wmdInput.on('change', function() {
                console.log('wmdInput changed', $wmdInput.val());
                var rawContent = $wmdInput.val();
                scope.$apply(function() {
                    ngModel.$setViewValue(rawContent);
                });
            });

            // parent scope -> local change
            scope.$watch(iAttrs.ngModel, function(value, oldValue) {
                console.log('ngModel changed', 'old: ', oldValue, 'new: ', value, editor, $wmdInput);
                // this does not really work, so we do it manually - what is the correct way?
                // scope.textareaValue = value;
                // if (value !== undefined) {
                if(value){
                    /*scope.$apply(function(){
                        textareaValue = value;
                        editor.refreshPreview();
                    })*/
                    alert(value);
                    $wmdInput.val(value);
                    //console.log($wmdInput.html());
                    editor.refreshPreview(); // forces the editor to re-render the preview according to the contents of the input, e.g. after you have programmatically changed the input box content. This method is only available after editor.run() has been called.
                    // 代码高亮支持
                    $('code').each(function(i, e) {
                        hljs.highlightBlock(e, null, true)
                    });
                }

            });
        }
    }
}])