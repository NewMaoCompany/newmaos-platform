import React, { useState, useEffect, useRef } from 'react';
import { useNavigate } from 'react-router-dom';

const SEARCH_SUGGESTIONS = [
  { title: 'Douyin', url: 'https://www.douyin.com', icon: 'smart_display', color: '#fe2c55' },
  { title: 'Google', url: 'https://www.google.com', icon: 'search', color: '#4285f4' },
  { title: 'GitHub', url: 'https://www.github.com', icon: 'code', color: '#24292e' },
  { title: 'Wikipedia', url: 'https://www.wikipedia.org', icon: 'menu_book', color: '#000000' },
  { title: 'Stack Overflow', url: 'https://stackoverflow.com', icon: 'terminal', color: '#f48024' },
  { title: 'Prestige', url: '/prestige', icon: 'workspace_premium', color: '#f9d406', internal: true },
];

export const VirtualBrowser = () => {
  const navigate = useNavigate();
  const [url, setUrl] = useState('');
  const [isSearching, setIsSearching] = useState(false);
  const [history, setHistory] = useState<string[]>([]);
  const [activeTab, setActiveTab] = useState('Home');
  const [isIframeBlocked, setIsIframeBlocked] = useState(false);
  const iframeRef = useRef<HTMLIFrameElement>(null);

  const handleSearch = (e?: React.FormEvent) => {
    e?.preventDefault();
    if (!url.trim()) return;

    let targetUrl = url.trim();
    if (!targetUrl.startsWith('http')) {
      if (targetUrl.includes('.') && !targetUrl.includes(' ')) {
        targetUrl = `https://${targetUrl}`;
      } else {
        // Mock Google Search
        targetUrl = `https://www.google.com/search?q=${encodeURIComponent(targetUrl)}`;
      }
    }

    setHistory(prev => [targetUrl, ...prev].slice(0, 10));
    setIsIframeBlocked(false);
    
    // Simulate navigation
    if (targetUrl.startsWith('/')) {
        navigate(targetUrl);
    } else {
        // Most sites will block iframe, so we show a simulator UI
        setIsSearching(true);
        setActiveTab(targetUrl);
    }
  };

  const handleSiteClick = (site: typeof SEARCH_SUGGESTIONS[0]) => {
      if (site.internal) {
          navigate(site.url);
      } else {
          setUrl(site.url);
          setIsSearching(true);
          setActiveTab(site.title);
          setIsIframeBlocked(false);
      }
  };

  return (
    <div className="fixed inset-0 z-[100] flex flex-col bg-[#f8f9fa] text-black font-sans select-none overflow-hidden">
      {/* Browser Header / Address Bar */}
      <div className="w-full bg-white border-b border-gray-200 px-4 py-3 flex items-center gap-4 z-50 shadow-sm">
        <div className="flex items-center gap-2">
           <button onClick={() => navigate('/lobby')} className="w-8 h-8 rounded-full hover:bg-gray-100 flex items-center justify-center transition-colors">
              <span className="material-symbols-outlined text-gray-600 text-[20px]">close</span>
           </button>
           <div className="flex items-center gap-1">
             <button onClick={() => setIsSearching(false)} className="w-8 h-8 rounded-full hover:bg-gray-100 flex items-center justify-center disabled:opacity-30">
                <span className="material-symbols-outlined text-gray-600 text-[20px]">arrow_back</span>
             </button>
             <button className="w-8 h-8 rounded-full hover:bg-gray-100 flex items-center justify-center disabled:opacity-30">
                <span className="material-symbols-outlined text-gray-600 text-[20px]">arrow_forward</span>
             </button>
             <button onClick={() => setIsSearching(false)} className="w-8 h-8 rounded-full hover:bg-gray-100 flex items-center justify-center">
                <span className="material-symbols-outlined text-gray-600 text-[20px]">home</span>
             </button>
           </div>
        </div>

        <form onSubmit={handleSearch} className="flex-1 max-w-xl mx-auto relative group">
          <div className="absolute left-4 top-1/2 -translate-y-1/2 flex items-center gap-2">
            <span className="material-symbols-outlined text-gray-400 text-[18px]">search</span>
          </div>
          <input 
            type="text" 
            value={url}
            onChange={(e) => setUrl(e.target.value)}
            placeholder="Search or enter URL"
            className="w-full bg-gray-100 border-none rounded-full py-2.5 pl-11 pr-4 text-sm focus:ring-2 focus:ring-blue-500/20 focus:bg-white transition-all outline-none"
          />
        </form>

        <div className="flex items-center gap-2">
           <button className="w-8 h-8 rounded-full hover:bg-gray-100 flex items-center justify-center text-blue-600 font-black">
              N
           </button>
        </div>
      </div>

      {/* Main Content Area */}
      <div className="flex-1 relative overflow-hidden">
        {!isSearching ? (
          <div className="h-full flex flex-col items-center justify-center px-6 animate-page-in">
             <div className="mb-12 text-center pointer-events-none">
                <h1 className="text-6xl sm:text-8xl font-black italic tracking-tighter bg-clip-text text-transparent bg-gradient-to-r from-blue-500 via-red-500 to-yellow-500 mb-2">NewMaoS</h1>
                <p className="text-[12px] font-black uppercase tracking-[0.6em] opacity-30 text-black">Universal Search Engine</p>
             </div>

             <div className="w-full max-w-2xl">
                <div className="grid grid-cols-3 sm:grid-cols-4 gap-8 sm:gap-12">
                   {SEARCH_SUGGESTIONS.map(site => (
                     <button 
                        key={site.title}
                        onClick={() => handleSiteClick(site)}
                        className="flex flex-col items-center gap-3 group animate-scale-in"
                     >
                        <div className="w-16 h-16 sm:w-20 sm:h-20 rounded-[28%] bg-white shadow-lg border border-gray-100 flex items-center justify-center transition-all duration-500 group-hover:scale-110 group-hover:shadow-2xl active:scale-95">
                           <span className="material-symbols-outlined text-3xl sm:text-4xl" style={{ color: site.color, fontVariationSettings: "'FILL' 1" }}>
                              {site.icon}
                           </span>
                        </div>
                        <span className="text-[11px] font-black text-gray-500 uppercase tracking-widest">{site.title}</span>
                     </button>
                   ))}
                </div>
             </div>

             <div className="mt-20 text-[11px] font-bold text-gray-400 uppercase tracking-widest flex items-center gap-4">
                <span>Privacy</span>
                <div className="w-1 h-1 bg-gray-300 rounded-full" />
                <span>Terms</span>
                <div className="w-1 h-1 bg-gray-300 rounded-full" />
                <span>Security</span>
             </div>
          </div>
        ) : (
          <div className="h-full flex flex-col bg-white animate-fade-in">
             {/* Virtual Site View */}
             <div className="flex-1 flex flex-col items-center justify-center p-12 text-center">
                <div className="w-24 h-24 rounded-full bg-gray-50 flex items-center justify-center mb-8 border border-gray-100 shadow-inner">
                   <span className="material-symbols-outlined text-5xl text-blue-500 animate-pulse">language</span>
                </div>
                <h2 className="text-3xl font-black text-black mb-4 uppercase tracking-tighter italic">
                   Requesting Connection...
                </h2>
                <div className="max-w-md bg-gray-50 rounded-3xl p-8 border border-gray-100 mb-10">
                   <p className="text-sm text-gray-600 leading-relaxed mb-6">
                      You are attempting to visit <span className="font-bold text-black">{activeTab}</span> via the NewMaoS Virtual Browser.
                   </p>
                   <div className="flex flex-col gap-3">
                      <button 
                         onClick={() => window.open(activeTab.startsWith('http') ? activeTab : `https://${activeTab}`, '_blank')}
                         className="w-full py-4 bg-black text-white rounded-2xl font-black text-sm uppercase tracking-widest shadow-xl active:scale-[0.98] transition-all"
                      >
                         Open in Real Browser
                      </button>
                      <button 
                         onClick={() => setIsSearching(false)}
                         className="w-full py-4 bg-gray-200 text-black/60 rounded-2xl font-black text-sm uppercase tracking-widest active:scale-[0.98] transition-all"
                      >
                         Return Home
                      </button>
                   </div>
                </div>
                <div className="flex items-center gap-2 opacity-30">
                   <span className="material-symbols-outlined text-[16px]">verified_user</span>
                   <span className="text-[10px] font-black uppercase tracking-widest">Secured by NewMaoS Proxy v1.2</span>
                </div>
             </div>
          </div>
        )}
      </div>

      <style>{`
        @keyframes scaleIn {
            from { transform: scale(0.9); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }
        .animate-scale-in { animation: scaleIn 0.8s cubic-bezier(0.16, 1, 0.3, 1); }
      `}</style>
    </div>
  );
};
