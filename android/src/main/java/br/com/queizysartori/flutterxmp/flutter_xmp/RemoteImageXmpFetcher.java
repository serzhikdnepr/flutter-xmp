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

import java.io.File;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

interface MetadataCallback {
    void onSuccess(Map<String, String> metadata);
}

class MetadataCallbackImp implements MetadataCallback {
    @Override
    public void onSuccess(Map<String, String> metadata) {

    }
}

public class RemoteImageXmpFetcher  {
    public static void fetch(String url, Context context, final MetadataCallback callback) {
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

    private static Map<String, String> readImageMetadata(File file) {
        Map<String, String> xmpData = new HashMap<String, String>();

        try {
            Metadata metadata = ImageMetadataReader.readMetadata(file);
            
            for (XmpDirectory xmpDirectory : metadata.getDirectoriesOfType(XmpDirectory.class)) {
                XMPMeta xmpMeta = xmpDirectory.getXMPMeta();
                XMPIterator itr = xmpMeta.iterator();
                while (itr.hasNext()) {
                    XMPPropertyInfo property = (XMPPropertyInfo) itr.next();
                    if (property.getPath() != null) {
                        xmpData.put(property.getPath(), property.getValue());
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return xmpData;
    }
}
