/*
 * Copyright (c) 2014 castLabs GmbH
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

package com.castlabs.dash.descriptors {
import com.castlabs.dash.descriptors.index.SegmentIndex;
import com.castlabs.dash.descriptors.index.SegmentIndexFactory;
import com.castlabs.dash.descriptors.segments.Segment;

public class Representation {
    private var _internalId:Number;
    private var _baseUrl:String;
    private var _duration:Number;
    private var _id:String;
    private var _bandwidth:Number;

    private var _segmentIndex:SegmentIndex;

    public function Representation(internalId:Number, baseUrl:String, duration:Number, xml:XML) {
        _internalId = internalId;
        _baseUrl = baseUrl;
        _duration = duration;
        _id = buildId(xml);
        _bandwidth = buildBandwidth(xml);
        _segmentIndex = SegmentIndexFactory.create(xml);
    }

    public function get internalId():Number {
        return _internalId;
    }

    public function get bandwidth():Number {
        return _bandwidth;
    }

    public function getInitializationSegment():Segment {
        return _segmentIndex.getInitializationSegment(_id, _bandwidth, _baseUrl, _internalId);
    }

    public function getIndexSegment():Segment {
        return _segmentIndex.getIndexSegment(_id, _bandwidth, _baseUrl, _internalId);
    }

    public function getSegment(timestamp:Number):Segment {
        return _segmentIndex.getSegment(timestamp, _id, _bandwidth, _baseUrl, _duration, _internalId);
    }

    public function update(xml:XML):void {
        _segmentIndex.update(xml);
    }

    private static function buildId(xml:XML):String {
        return xml.@id;
    }

    private static function buildBandwidth(xml:XML):Number {
        return Number(xml.@bandwidth);
    }
}
}
