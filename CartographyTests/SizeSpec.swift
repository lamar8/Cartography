import Cartography

import Nimble
import Quick

class SizeSpec: QuickSpec {
    override func spec() {
        var window: TestWindow!
        var view: TestView!

        beforeEach {
            window = TestWindow(frame: CGRect(x: 0, y: 0, width: 400, height: 400))

            view = TestView(frame: CGRect.zero)
            window.addSubview(view)
        }

        describe("LayoutProxy.size") {
            it("should support relative equalities") {
                constrain(view) { view in
                    view.size == view.superview!.size
                }

                window.layoutIfNeeded()

                expect(view.frame.size).to(equal(CGSize(width: 400, height: 400)))
            }

            it("should support relative inequalities") {
                constrain(view) { view in
                    view.size <= view.superview!.size
                    view.size >= view.superview!.size
                }

                window.layoutIfNeeded()

                expect(view.frame.size).to(equal(CGSize(width: 400, height: 400)))
            }

            it("should support multiplication") {
                constrain(view) { view in
                    view.size == view.superview!.size * 2
                }

                window.layoutIfNeeded()

                expect(view.frame.size).to(equal(CGSize(width: 800, height: 800)))
            }

            it("should support division") {
                constrain(view) { view in
                    view.size == view.superview!.size / 2
                }

                window.layoutIfNeeded()

                expect(view.frame.size).to(equal(CGSize(width: 200, height: 200)))
            }
        }

        #if os(iOS) || os(tvOS)
            describe("on iOS only") {
                beforeEach {
                    window.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                }

            if #available(iOS 11.0, *) {
                describe("LayoutProxy.safeArea.size") {
                    it("should support relative equalities") {
                        constrain(view) { view in
                            view.size == view.superview!.safeArea.size
                        }

                        window.layoutIfNeeded()

                        expect(view.frame.size).to(equal(CGSize(width: 400, height: 400)))
                    }

                    it("should support relative inequalities") {
                        constrain(view) { view in
                            view.size <= view.superview!.safeArea.size
                            view.size >= view.superview!.safeArea.size
                        }

                        window.layoutIfNeeded()

                        expect(view.frame.size).to(equal(CGSize(width: 400, height: 400)))
                    }

                    it("should support multiplication") {
                        constrain(view) { view in
                            view.size == view.superview!.safeArea.size * 2
                        }

                        window.layoutIfNeeded()

                        expect(view.frame.size).to(equal(CGSize(width: 800, height: 800)))
                    }

                    it("should support division") {
                        constrain(view) { view in
                            view.size == view.superview!.safeArea.size / 2
                        }

                        window.layoutIfNeeded()

                        expect(view.frame.size).to(equal(CGSize(width: 200, height: 200)))
                    }
                }
            }
        }
#endif
    }
}
