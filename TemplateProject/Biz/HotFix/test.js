
// test
require('UIView, UIColor, UILabel')
defineClass('TestViewController', {
            genView: function() { // replace method
                var view = self.ORIGgenView();
                view.setBackgroundColor(UIColor.greenColor())
                var label = UILabel.alloc().initWithFrame(view.bounds());
                label.setText("JSPatch");
                label.setTextAlignment(1);
                view.addSubview(label);
                console.log('genView');
                return view;
            },

            customMethod: function(param) { // add method
                console.log("customMethod:" + param);
            },
            
            viewDidLoad: function() { // replace method
                self.ORIGviewDidLoad();
            
                self.customMethod("this is a test");
            
                self.testMethodWithParam1_param2({
                                                 "key": "value"
                                                 },
                                                 block('NSString*,BOOL', function(content, success) {
                                                            console.log(content.toJS() + ' ' + success);
                                                            return "test block";
                                                          }));
            
                console.log('viewDidLoad');
            },
            
            testMethodWithParam1_param2: function(param1, param2) { // replace method
                self.ORIGtestMethodWithParam1_param2(param1, param2);
                console.log('testMethodWithParam1_param2');
            },
            
            });
