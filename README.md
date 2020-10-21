# eeUtil

Wrapper for easier data management with Earth Engine python sdk

Requires account with access to Google Cloud Storage and Earth Engine.

```
import eeUtil as eu

# initialize from environment variables
eu.init(bucket='mybucket')

# create image collection
eu.createFolder('mycollection', imageCollection=True)

# upload image to collection
eu.upload('image.tif', 'mycollection/myasset')
eu.setAcl('mycollection', 'public')
eu.ls('mycollection')
```

__Install__

`pip install -e git+https://github.com/resource-watch/eeUtil.git#egg=eeUtil`

__Develop__

```
git clone https://github.com/resource-watch/eeUtil.git
cd eeUtil
pip install -e .
```

Or with docker and docker compose thanks to [pyshipper](https://github.com/LINKIT-Group/pyshipper)

```
git clone https://github.com/resource-watch/eeUtil.git
cd eeUtil
make shell

## inside the container run where you are testing the 
python test.py

## to exit the container run
exit
```

### Nice things?

- More consistent python bindings
- GEE paths not starting with `/` or `users/` are relative to your user root folder (`users/<username>`)
- Upload atomatically stages files via Google Cloud Storage

### Usage

eeUtil defaults to reading from credentials saved by `gcloud auth` for Google Cloud Storage and `earthengine authenticate` for Earth Engine. In your script, initialize these credentials with `eeUtil.init()`. These credentials are read from environment variables as follows.

```
# environment variables
export GEE_SERVICE_ACCOUNT=<my-account@gmail.com>
export GOOGLE_APPLICATION_CREDENTIALS=<path/to/credentials.json>
export CLOUDSDK_CORE_PROJECT=<my-project>
export GEE_STAGING_BUCKET=<my-bucket>
```

Alternatively credentials can be provided directly to `eeUtil.init()` via a json credential file or via a json string in the `GEE_JSON` environment variable.

```
eeUtil.init([service_account=], [credential_path=], [project=], [bucket=])
```
 - `service_account` Service account name. If not specficed, reads defaulds from `earthengine authenticate`. For more information on GEE service accounts, see: https://developers.google.com/earth-engine/service_account `[default: GEE_SERVICE_ACCOUNT]`
 - `credential_path` Path to json file containing private key. Required for service accounts. `[default: GOOGLE_APPLICATION_CREDENTIALS]`
 - `project` GCS project containing bucket. Required if account has access to multiple projects. `[default: CLOUDSDK_CORE_PROJECT]`
 - `bucket` Storage bucket for staging assets for ingestion. Will create new bucket if none provided. `[default: GEE_STAGING_BUCKET]`



