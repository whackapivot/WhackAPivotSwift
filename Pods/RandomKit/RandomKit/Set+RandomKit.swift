//
//  Set+RandomKit.swift
//  RandomKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Nikolai Vazquez
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

extension Set where Element: RandomType {

    private init(_ randomCount: Int, _ sequence: AnySequence<Element>, @autoclosure _ elementGenerator: () -> Element) {
        self = sequence.reduce(Set(minimumCapacity: randomCount)) { (var set, var element) in
            while set.contains(element) { element = elementGenerator() }
            set.insert(element)
            return set
        }
    }

    /// Construct a Set of random elements.
    public init(randomCount: Int) {
        self.init(
            randomCount,
            Element.randomSequence(maxCount: randomCount),
            Element.random())
    }

}

extension Set where Element: RandomIntervalType {

    /// Construct a Set of random elements from inside of the closed interval.
    ///
    /// - Precondition: Number of elements within `interval` >= `randomCount`.
    ///
    public init(randomCount: Int, _ interval: ClosedInterval<Element>) {
        self.init(
            randomCount,
            Element.randomSequence(interval, maxCount: randomCount),
            Element.random(interval))
    }

}
