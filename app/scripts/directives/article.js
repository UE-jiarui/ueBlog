
BlogDirectives.directive("mdEditor", ['$compile', function($compile){
    var nextId = 0;
    var markdownConverter = new Markdown.Converter();
    return {
        require: 'ngModel',
        replace: true,
        template: '<div class="pagedown-bootstrap-editor"></div>',
        link: function(scope, iElement, iAttrs, ngModel) {
            var editorUniqueId = nextId++;
            var newElement = $compile('<div>' + '<div class="wmd-panel" ng-show="postArgs.isEdit">' + '<div id="wmd-button-bar-' + editorUniqueId + '"></div>' + '<textarea class="wmd-input form-control" rows="30" id="wmd-input-' + editorUniqueId + '" ng-model="article.content" placeholder="请输入文章内容">' + '</textarea>' + '</div>' + '<div id="wmd-preview-' + editorUniqueId + '" class="wmd-panel wmd-preview" ng-hide="postArgs.isEdit"></div>' + '</div>')(scope);
            iElement.html(newElement);
            // 初始化
            var converter = new Markdown.Converter();
            var editor = new Markdown.Editor(converter, "-" + editorUniqueId);
            editor.run();

            var $wmdInput = $("#wmd-input-" + editorUniqueId);

            // 实现预览
            $wmdInput.on('change', function() {
                var rawContent = $wmdInput.val();
                scope.$apply(function() {
                    ngModel.$setViewValue(rawContent);
                });
            });

            scope.$watch(iAttrs.ngModel, function(value, oldValue) {
                // console.log('ngModel changed', 'old: ', oldValue, 'new: ', value, editor, $wmdInput);
                if(value){
                    $wmdInput.val(value);
                    editor.refreshPreview(); // forces the editor to re-render the preview according to the contents of the input, e.g. after you have programmatically changed the input box content. This method is only available after editor.run() has been called.
                }

            });
        }
    }
}])
.directive("articleList",['$compile','$interval', '$location', function($compile, $interval, $location){
    return { 
        restrict: 'AE',
        replace: true,
        scope: { articles:'=' ,paginate:'=' },
        templateUrl: '/scripts/directives/articleList.html',
        link: function(scope, iElement, iAttrs){
          // 翻页跳转
          scope.pageChanged = function (pageNo) {
            $location.path("/blog/page/" + pageNo);
          };
        }
    }
}])
.directive("articleContent", ["$compile", function($compile){
    return {
        restrict: 'A',
        replace: true,
        scope: { content:'='},
        template: '<p class="article_content"></p>',
        link: function(scope, iElement, iAttrs){
            // 取前10个元素进行预览
            var content = $compile(scope.content)(scope),
                myArticle = iElement;
            
            for(var i = 0; i < 5; i++){
                myArticle.append(content.eq(i));
            }
            iElement.append(myArticle);
        }
    }
}])


/**
 * 富文本编辑器封装指令
 *
 */
// BlogDirectives.directive('richTextEditor', function($location, $compile) {
//     var self = this;
//     var directive = {
//         restrict: "A",
//         replace: true,
//         transclude: true,
//         scope: {

//         },
//         template: "<div id='rich_text_editor'>" +
//             "<textarea id=\"richtexteditor-content\" style=\"height:300px;width:100%\"></textarea>" +
//             "</div>",

//         link: function($scope, $element, $attrs) {
//             $scope.editor = $('#richtexteditor-content').wysihtml5();

//             // $compile($("#rich_text_editor"))($scope);

//             //                        $scope.editor = new wysihtml5.Editor( "richtexteditor-content", {

//             //                                toolbar : "richtexteditor-toolbar",
//             //                              parserRules: wysihtml5ParserRules       
//             //                    });

//             $scope.$parent.$watch($attrs.content, function(newValue, oldValue) {

//                 $scope.editor.innerHTML = newValue;
//                 $scope.editor.data('wysihtml5').editor.composer.setValue( newValue || '' );
//                 // $scope.editor.composer.setValue(newValue);
//             });
//             $compile($element.contents())($scope);

//             $scope.cancel = function() {
//                 $scope.$parent.cancel();
//             }
//             /* $scope.save = function() {
//                     var currentTemplateContent = $encryption.encodeHtml( $scope.editor.getValue() );
//                     $scope.$parent.currentTemplate.content = currentTemplateContent;
//                     $scope.$parent.save();
//             }
//             */
//             $scope.isClean = function() {
//                 $scope.$parent.isClean();
//             }
//         }
//     }
//     return directive;
// })