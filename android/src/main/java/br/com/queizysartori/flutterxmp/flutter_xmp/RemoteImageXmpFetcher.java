package br.com.queizysartori.flutterxmp.flutter_xmp;
import android.content.Context;
import android.graphics.drawable.Drawable;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.embedding.engine.plugins.activity.ActivityAware;

import com.adobe.internal.xmp.XMPIterator;
import com.adobe.internal.xmp.XMPMeta;
import com.adobe.internal.xmp.properties.XMPPropertyInfo;
import com.bumptech.glide.Glide;
import com.bumptech.glide.request.target.CustomTarget;
import com.bumptech.glide.request.transition.Transition;
import com.drew.imaging.ImageMetadataReader;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.Tag;
import com.drew.metadata.xmp.XmpDirectory;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.IntBuffer;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

class XmpResult {
    byte[] imageData;
    Map<String, String> metadata;

    Map toMap() {
       HashMap map = new HashMap();
       map.put("image_data", imageData);
       map.put("metadata", metadata);

       return map;
    }
}

interface MetadataCallback {
    void onSuccess(XmpResult result);
}

class MetadataCallbackImp implements MetadataCallback {
    @Override
    public void onSuccess(XmpResult result) {

    }
}

public class RemoteImageXmpFetcher  {
    public static void fetchRemote(String url, Context context, final MetadataCallback callback) {
        Glide.with(context)
        .asFile()
        .load(url)
        .into(new CustomTarget<File>() {
            @Override
            public void onResourceReady(@NonNull File resource, @Nullable Transition<? super File> transition) {
                callback.onSuccess(readImageMetadata(resource));
            }

            @Override
            public void onLoadCleared(@Nullable Drawable placeholder) { }
        });
    }
    public static void fetchLocale(String url, Context context, final MetadataCallback callback) {
       File file = new File(url);
        callback.onSuccess(readImageMetadata(file));
    }
    private static XmpResult readImageMetadata(File file) {
        XmpResult result = new XmpResult();

        try {
            Map<String, String> metadataMap = new HashMap();

            Metadata metadata = ImageMetadataReader.readMetadata(file);
            
            for (XmpDirectory xmpDirectory : metadata.getDirectoriesOfType(XmpDirectory.class)) {
                XMPMeta xmpMeta = xmpDirectory.getXMPMeta();
                XMPIterator itr = xmpMeta.iterator();
                while (itr.hasNext()) {
                    XMPPropertyInfo property = (XMPPropertyInfo) itr.next();
                    if (property.getPath() != null) {
                        metadataMap.put(property.getPath(), property.getValue());
                    }
                }
            }

            result.metadata = metadataMap;

            int size = (int) file.length();
            byte[] bytes = new byte[size];

            BufferedInputStream buf = new BufferedInputStream(new FileInputStream(file));
            buf.read(bytes, 0, bytes.length);
            buf.close();

            result.imageData = bytes;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}
