"""
Streamlit wrapper for a YData Profiling HTML report.
Notes:
- YData prints a marketing banner to stdout at import/build time; we silence stdout/stderr
  around those calls so the terminal stays clean.
- The report is embedded as a data:URL iframe to isolate its internal hash-based navigation
  (which otherwise can trigger Streamlit reruns and cause nested renders).
"""

import os
import logging
import seaborn as sns
import base64
import contextlib
from io import StringIO
import streamlit as st
import streamlit.components.v1 as components
import webbrowser


# We rely on _silence_stdio() instead of env/warning filters; it's more robust across versions.


@contextlib.contextmanager
def _silence_stdio():
    """Temporarily redirect stdout/stderr to avoid YData's import-time/HTML build prints.
    This is more reliable than warnings/logging filters because the library uses raw prints.
    """
    _out_cm = contextlib.redirect_stdout(StringIO())
    _err_cm = contextlib.redirect_stderr(StringIO())
    with _out_cm, _err_cm:
        yield


with _silence_stdio():
    from ydata_profiling import ProfileReport

# Silence Streamlit's bare-mode warning noise when launched as a plain script
logging.getLogger("streamlit.runtime.scriptrunner_utils.script_run_context").setLevel(
    logging.ERROR
)


def _running_in_streamlit() -> bool:
    try:
        from streamlit.runtime.scriptrunner import get_script_run_ctx  # type: ignore

        return get_script_run_ctx() is not None
    except Exception:
        return False


df = sns.load_dataset("titanic").drop(columns=["alive"])


def _build_profile_html():
    """Build the profiling report HTML once.
    Wrapped in _silence_stdio() to suppress upstream prints; callers cache this output
    (Streamlit uses @st.cache_data outside this helper) and embed via data:URL iframe
    to sandbox hash-based navigation.
    """
    with _silence_stdio():
        profile = ProfileReport(
            df,
            title="Data Profile",
            explorative=True,  # enables extra tabs & drilldowns
            minimal=False,  # keep full computations
            correlations={
                "pearson": {"calculate": True},
                "spearman": {"calculate": True},
                "kendall": {"calculate": True},
                "phi_k": {"calculate": True},
            },  # if you have mixed types
            missing_diagrams={"heatmap": True, "dendrogram": True, "matrix": True},
            interactions={"continuous": True},
            samples={"head": 10, "tail": 10},  # ensure Sample tab has content
        )
        html = profile.to_html()
    return html


if _running_in_streamlit():

    @st.cache_data(show_spinner="Building YData Profile HTML…")
    def get_profile_html():
        return _build_profile_html()

    st.set_page_config(layout="wide")
    st.title("YData Profiling + Streamlit Test")
    st.write("Here's the profile report in HTML form:")
    profile_html = get_profile_html()
    # Render via data: URL to isolate the report and prevent iframe-within-iframe stacking
    b64 = base64.b64encode(profile_html.encode("utf-8")).decode("ascii")
    components.iframe(f"data:text/html;base64,{b64}", height=3000, scrolling=True)
else:
    # Use the same cached builder for script mode
    profile_html = _build_profile_html()
    with open("profile_report.html", "w", encoding="utf-8") as f:
        f.write(profile_html)
    print("Profile report saved to profile_report.html")
    abs_path = os.path.abspath("profile_report.html")
    webbrowser.open(f"file://{abs_path}")
